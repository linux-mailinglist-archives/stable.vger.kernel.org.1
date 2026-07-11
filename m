Return-Path: <stable+bounces-273419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N7jHIRpdUmpcOwMAu9opvQ
	(envelope-from <stable+bounces-273419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 17:11:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D95741E9F
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 17:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dyBBpbOd;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273419-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273419-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE88F3042C54
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6C2C11EE;
	Sat, 11 Jul 2026 15:08:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174F29A9C3
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782494; cv=none; b=kYa/xV3XUTMkQpMPpAV0Qv6a/pc+ipwVScDsE3Y0eheXK3/osEC4a9YCYO0Fd75+dvurPaEUQ9hPASUvkhi/MKV55jO6Tj5NTgT417qN0gh1JsbWJJ1DoBsmRYoGfbhrE8ElUNk4tgy9qavM8c9BAc2ewRFJx9+xv/qryerqILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782494; c=relaxed/simple;
	bh=CdhefricwWhFH7olfPqmXW38H4i9Ji9hk0aWVmUDFfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUUnHdfLDpSLC7ngsN4hsmAYcHgks/F73OIanW91QSoMNu6kweSWNXUiF1cKdFuwhw/hQuuHwQuwkAfuL45Y+JFn9jPzLCjUFqdNDW9husCNoub33/W9oFi+BAJDEUFgbwEgW4KKu93ZizGREwfAhFRT6J2+copwgtkEOo05ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyBBpbOd; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8eeb4508f29so14479446d6.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782492; x=1784387292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Typ9h20vIh7Ab90myOn31vTAuGHIxFcn9F7x3mbLByY=;
        b=dyBBpbOdlwY5NsCIFVD/UnyDvcBpE1Ka5KjOrWp5RJMr1Nn8NAeFrFZTGWxHUqWWwo
         LhlV6Ja9+Y60stjQZYeacn+/lfBfZ/TPHWts5B5n0h9x/CH85ObRXkJ3SYS3zqV7fq2E
         ZDEFbvmrEig2nzNyinnYl1Dv17EuMo5HrIzuGugjTS/IP0AzYVY+US9Y25vlRXgfMOIj
         0E3QvWt4kWdJERNw8kDCRf8npcy+z+zW2QsifH0h6ee2wvclUCfIZOf39DGPpub0higq
         QO6GwEk/EIN+fL+Wgw54QeuXTGgCBtjihGGoQvr5HyNV7qMB8jSv1AwaABcfiUfEwOov
         UunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782492; x=1784387292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Typ9h20vIh7Ab90myOn31vTAuGHIxFcn9F7x3mbLByY=;
        b=lKEEPa3MSq9aboUKfRVI/C6A32EcghjDxf1PKJ2uUe53BiFIjCHBxekL2OFE49j18I
         amaOuHdMNhTthvAK6t/FmUhDkbjisacnRaXO99EQIAUhkwYZFYWQbd3edwdkLsqUHfOh
         DvetrwCO6NoWewKCeOo8uRO2g8aKlsjwTEN1f9ZT+C6LRjQ/yNzy/KrZNMlhDQjw+v7n
         Q0RId+IshwAb5QGBeQ6jhHZsL4RiUgUb6v3YtU+dqNCWQkv30zFWz2AYxkNJ59dDxIsp
         pAK0Nl3SMJSaeMYcx7tKCCrReWXu4PvQSbk79UP8Qtlj2X58Hwt1fwIsoFawVU7aqM3A
         AoBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1HiB9sCAZCqCw9qYRoBSkO8zAoeVSXWFyKrfxSvyRlGRTkPlKhQ2pcl4Sy3DvD7W8NJKlCdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXIVQFWCiI8akRI5bTedUn4SWyXsyAEDq/DzWMnt+SdT8Q2R3
	ZkjCzbh2iAJER8D2vyPFat0bhCpon1ueu95itZG6KzeOtvq9+cUhFvF+
X-Gm-Gg: AfdE7cm/Y6YPZ+3zEWkShSR4LP1J5p9iolxYAzlaVlTNhH5vn9aYNJ0ezCsSDnwFFKC
	XaaiDt7sDdvEAwOd4MFY2Ps1fnpYyfKPBnE6le+8Yr2ybr8nUagJ3/EdHVkfAKXTm6a8zDbErfG
	32TcEF1yO865u5eSDw8e+pnIK9fO7DmB8xflbYbfKczKBH6MDgZ5erbadK88zAUJRIvQZODe74K
	MeipiUKqzK7Zkl9whzAMLmG6CG6YbLbi4GwRWjV5s4jKwoC53f/0lorUtHDOAqnZFaHvNKb0I5p
	OmfubK/VRzqoEZ52xI1E6TOSddV6Cesm200apjO+TuyTeqNPoLrRChDlYaCXkAL+q1AMPE6Rou5
	dlDZ93tPyV5yUz6vZ6VU2EO4oiGPONeDg999G1/8YM2gi2mH8EnXlbl0O1rqRPjP13utkPmr43V
	jkG8gVatWI9NWY36/TXM16jGjBmRF52aScJXUVGUC5p7H8NGBA2qZWPeRWlvnPMhO0l6HJ5jjIc
	i8000pU9w==
X-Received: by 2002:a05:620a:608e:b0:92e:93a6:4eaa with SMTP id af79cd13be357-92ef2b567c1mr345018485a.32.1783782491736;
        Sat, 11 Jul 2026 08:08:11 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf98sm69401616d6.17.2026.07.11.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:08:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: reject an over-long name in get_name_filldir
Date: Sat, 11 Jul 2026 11:08:08 -0400
Message-ID: <20260711150808.2919076-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273419-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:agruenba@redhat.com,m:gfs2@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9D95741E9F

get_name_filldir() copies a directory entry name into the caller's fixed
GFS2_FNAMESIZE-byte buffer with memcpy(gnfd->name, name, length) without
checking length against GFS2_FNAMESIZE. A gfs2 directory entry whose name
length exceeds GFS2_FNAMESIZE, as produced by a corrupted or crafted
on-disk directory, overflows the buffer.

Impact: an out-of-bounds write past the GFS2_FNAMESIZE name buffer (KASAN)
in the NFS-export get_name path, reachable when a gfs2 filesystem carrying
a crafted directory entry is re-exported over NFS.

Reject entries whose name length exceeds GFS2_FNAMESIZE before the copy.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/gfs2/export.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9cb..7b28f1eb9ad0d 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -76,6 +76,9 @@ static bool get_name_filldir(struct dir_context *ctx, const char *name,
 	if (inum != gnfd->inum.no_addr)
 		return true;
 
+	if (length > GFS2_FNAMESIZE)
+		return false;
+
 	memcpy(gnfd->name, name, length);
 	gnfd->name[length] = 0;
 
-- 
2.53.0


