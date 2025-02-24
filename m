Return-Path: <stable+bounces-119388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B44A427AC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1141660A5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3C2627E6;
	Mon, 24 Feb 2025 16:19:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF125A64D
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413989; cv=none; b=NcZuKb0fHUj10LZF47sjkZHa9vy1iECheL1PVxd5sY5U26Zos69iKilJF53NF8bOXCSWDQqaApWCw7A48EcyYgwvTCuJeNw/NnCpwRE1geJ+3U7t1O1OHPANtLdqMoF9rr2CX1iNlrFw3caMkN/JfCDc09LKB3UraVk46lR4l80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413989; c=relaxed/simple;
	bh=DG1bgBKQKe1Yao60YzoGDpgtWXH3WgkCCNde1Eirofc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V4X0qGSAEvoHcdQMbNmzCGx5pc2lvtPwa14DF9YEQ36AEtF7Zf13GING6eF9aJdezQZOAoMVUx97ybHal5FUSYinpzEJqb4wtGQspcgeTAXWYdbW7uSvaSNprXUsWTxm6pyv1vo3FZGgAF9PQHVWJGuBmI8XDnHG7nc+ToL1Zks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tmape-006Lnk-0x;
	Mon, 24 Feb 2025 15:57:20 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tmapc-00000003ITd-0Sr4;
	Mon, 24 Feb 2025 16:57:20 +0100
Date: Mon, 24 Feb 2025 16:57:20 +0100
From: Ben Hutchings <benh@debian.org>
To: stable@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>
Subject: [PATCH 5.4,4.10 1/2] perf cs-etm: Add missing variable in
 cs_etm__process_queues()
Message-ID: <Z7yW4FuPxoZyl7Ga@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sakp35lMycL1GvsD"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--sakp35lMycL1GvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 5afd032961e8 "perf cs-etm: Don't flush when packet_queue fills
up" uses i as a loop counter in cs_etm__process_queues().  It was
backported to the 5.4 and 5.10 stable branches, but the i variable
doesn't exist there as it was only added in 5.15.

Declare i with the expected type.

Fixes: 1ed167325c32 ("perf cs-etm: Don't flush when packet_queue fills up")
Fixes: 26db806fa23e ("perf cs-etm: Don't flush when packet_queue fills up")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e3fa32b83367..2055d582a8a4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2171,7 +2171,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr;
+	unsigned int cs_queue_nr, queue_nr, i;
 	u8 trace_chan_id;
 	u64 timestamp;
 	struct auxtrace_queue *queue;


--sakp35lMycL1GvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAme8ltQACgkQ57/I7JWG
EQnGyhAAtTmMwj9VPSfl6cBc4VcBdKyELPY8S2WOPnqU+7rUxQgbZyVKOE5pzjuV
/VXQfTRwYo3vY2aHGbhX87U9X2vhLIDSezFyiYav17QRPRSheguPyGklwaytP2Dy
dkHQMDNwI/sVO/X3Aby4GS/sX+4gaVIQOPGTESC/uW3Tum+Iwq1hInDqq3a/coF9
NL15wrNGJ/MK8WD7mBxSmmdvWI6mlg5bnDCDdeQVzCx0ahsnikOKrRVbpk/1Qmrd
ZltomqdQP5n8RLYVX/pWbrDI8bZNMs1CUEsfHuzzLmRrfs3owNgaNQJY2tS6SO8p
Q2INr7PRxtMeTZW6q6juUfY8JhMfFO7zZotgPpagHzcBZGDszzMQXdTFRiCHE4Ex
wSYUcGWpsfo/DBboFUsVaaO39Vz2sA+qWJhaiLpLaTCQr4zvnnx8B1oGoTM7twjl
GUtsQNKfWPsTXgt2Ku/XPl/0e06YE6y1jTY+x7ZRqpk+vfirWcOI37UA2u7d8uG2
VIT27qT2EVF+05t7BPDR5yr78m0mSfyfHG8cvkIGs+p6Ajg8CaBR3sf6CcWDl7Ud
codTu6mL0r/OMX7LMAA+BZBiEL+pMjxC5n45VZ1rBpOGABkcCAwrXKbnsYwZx5fc
rqI91IGHe2tn/hVhOHp5ALOM4F9fefssfNs5DEG2biRmDV2fiFc=
=K7ID
-----END PGP SIGNATURE-----

--sakp35lMycL1GvsD--

