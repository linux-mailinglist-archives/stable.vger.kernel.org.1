Return-Path: <stable+bounces-119387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C421A42757
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D73B61CE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CD221F17;
	Mon, 24 Feb 2025 16:00:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58E191484
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412833; cv=none; b=UZJHhBQ2Qb+QnAW1I6NJ4CPUNP4JI8mGaojMx/MYwzejtFJ6LPM1pxdmZhS2lGFNq95mMVwr9qUvedUv3+pIiuETWqPR/JmCRWltIbks4ltC74wTYmlyF7BVjJ1TAuQc2Zh2Ydezu6Cz2HXlkLchqKq21+PsMas80T9mdYbRVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412833; c=relaxed/simple;
	bh=MCGSC2SnhdT+5ujSbZQTS2s84YuH4WtsJTu6QdL43pI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ommo2p7kdWumE4v5qrA1JoQWlgLg5knfmXlYzaj/aqQsQIeq3MBFOBtNYzGyZQjqQExwpqSDT/pPU3Fabb4fPmXw640NtcCFlDqfvAa7gowbub1qcNZiNlaEQrXTJe/MUhQFdjA8k44idFfCEEbJ/y4UZbW76wTHDXa2sYCU644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tmasg-006Lop-1R;
	Mon, 24 Feb 2025 16:00:29 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tmasd-00000003IaY-3UBT;
	Mon, 24 Feb 2025 17:00:27 +0100
Date: Mon, 24 Feb 2025 17:00:27 +0100
From: Ben Hutchings <benh@debian.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with mixed
 type arguments
Message-ID: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tdaUaB4cB9Sci6D/"
Content-Disposition: inline
In-Reply-To: <Z7yW4FuPxoZyl7Ga@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--tdaUaB4cB9Sci6D/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit ebbe26fd54a9 "udf: Avoid excessive partition lengths"
introduced a use of check_add_overflow() with argument types u32,
size_t, and u32 *.

This was backported to the 5.x stable branches, where in 64-bit
configurations it results in a build error (with older compilers) or a
warning.  Before commit d219d2a9a92e "overflow: Allow mixed type
arguments", which went into Linux 6.1, mixed type arguments are not
supported.  That cannot be backported to 5.4 or 5.10 as it would raise
the minimum compiler version for these kernel versions.

Add a cast to make the argument types compatible.

Fixes: 1497a4484cdb ("udf: Avoid excessive partition lengths")
Fixes: 551966371e17 ("udf: Avoid excessive partition lengths")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index ae75df43d51c..8dae5e73a00b 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1153,7 +1153,7 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
 		/* Check whether math over bitmap won't overflow. */
 		if (check_add_overflow(map->s_partition_len,
-				       sizeof(struct spaceBitmapDesc) << 3,
+				       (u32)(sizeof(struct spaceBitmapDesc) << 3),
 				       &sum)) {
 			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
 				map->s_partition_len);

--tdaUaB4cB9Sci6D/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAme8l5sACgkQ57/I7JWG
EQkR9g//YaZTGRwy6yCOgQQxUzk9Fy9tqriqumRDMJTa9cps7cJ47jF84r7hb3Kx
9kzMeqqTVfMj9DN1ZGBeWDUe9eD4mTVlnfVOdk9ndqLW8+kiAEhbyy1WGOXbnOrS
BygQl4W6saGMbTIblaEAOSMJRnUP9rj8KUuIyYbnj1o4tHij/qVsh62hmm8nICZc
vAfzwvBBy7tXGjb7iSa8r7x7ZA7hB8M+8iyEIrTW4DUgWSQ/d3cYY4kTQ0DQDcXB
lzB6/4s0C45X0Rus5oitwHLDKV4Djd0T5WPKTOju3T0yd7JmoZ2jzcRuUsW3Sum7
Ff+imCyCS+ItAeakQO4sTVvAoJzHhIyhs0fBeRVMmfxFV1v0eAnpDswvEV5mjISW
Mee/Z+iOvO6giL14rNuv9ktDk4C1Zj0Fff2HpAOvHBv7e52L+4TfrRCMjlNwFjJ5
PJG/2tWPC5+4NaKqHEvrhWR81WZ6qpMy0AzmTXE1lEoja88HLIE+ZCmp1C/OG5W9
LMCr6HDRZCRoCsPusDPzU6nIIa11LLanL+zkxjEVl8tFnq6bGAny7w5nlrXO+fPM
s4jI0zS5LttDKKDglOa6TBQONmKiikx0ReRhH9VESMQyJvWGlqyCieVFcLxLf1YO
vorBmscbY8ZYZkB0ld9WqzIhBPdUtYqN2fw+hWpcAPRbi0yglLU=
=bwFO
-----END PGP SIGNATURE-----

--tdaUaB4cB9Sci6D/--

