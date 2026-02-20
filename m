Return-Path: <stable+bounces-217532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fn7AlDXl2k99QIAu9opvQ
	(envelope-from <stable+bounces-217532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:38:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4321646DC
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6199B302E93C
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440232DECC2;
	Fri, 20 Feb 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2mzisgh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F572DC349
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558728; cv=none; b=fwyx76miHkyv/xEpympzG4XvYNVDBzh223T9qnPF/O+3oRpmjjbWRGErTIQOQg7z1Gyv96WLXYOfszZ222mdTdzbmS4bFoDJfdMi/jIOpXTt42XtPCMe4EFh81EWBVdJ0P9XS0BBXoqeXdObwAI2/pEE78mnrsfq9jm01E6KcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558728; c=relaxed/simple;
	bh=ERiI0ik+7C8U2bOZoMUPA8NBk6mNeP8oUH1ilI5DrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hE7BjGrwreHBbqKn1wBS4sMyReXDnBGuQN+0XBW5xId7tBCEm9D+Tf+QDbpeZFM0pJxHD6pFik1hJOO1exHLzsdpx0Hkagp9keOhIurZgYTsxSX7fTgfcxc4qXovgx8a1XVyW+CWpZoqeilu734im3+C6fNk9aGw2L2MAGl7qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2mzisgh; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649278a69c5so2181383d50.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 19:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771558726; x=1772163526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYi5KdDTrgKmUbM9Hgtml02i+c073pK3aRdi4XL87EQ=;
        b=I2mzisghLi54jACxIHeX8n3kJC+GUbKVsBaMTS0RIZ1mrQ7Uy+rXOU5GNEbSJJ5kVj
         d96b8G2UbQKwo1R1/3iv5Xc4kb5Nnl7UqbnqWwJxsqmPkTFrgVT+bMl9Wcm5J1OooJQ6
         TI+5UDTRMCa0r0UtTkS6m0d4vf/fG+QIZ28K71uLaxB7Gxmw6iPmi8vLveN7Sgsujf4a
         h2ljmIBhLr8qR1pbzqgX6OM77tMCFM9QsL7WTwQMR4nTtjZfQHtdAvJi4dk6MFxKMU8K
         oOKkszHSEZyPGz8xUpUW3rC7z0f7jfq65VQA/L5uuRhEdAJVYFPImPyfyGny9rGvH+Te
         ozYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558726; x=1772163526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYi5KdDTrgKmUbM9Hgtml02i+c073pK3aRdi4XL87EQ=;
        b=Gbhd0Mhdzx+l1ilksDG/8fMaCQZs8faJAfY9hTvxFWUKs3rGvMKCCLBZTu5SwXtxwu
         NrfjDI+gYcCpFKBf0PmDpqVQI21EITXKevo32M2izSJPtNRZaTkrjs/iFLnGOA3Jxy84
         kq+/khFydzfowjLk71sZUdr9OCbvUKI9v8ZhvCm7y2kl37l0dNlnsJ7UcQTMdvqqci6U
         PVxfKjxp2dopUrFM9xxoI1IM44lRWc1RnYJxsJxlrDFzAJ+nIH6E3qmY9zRo1aiWdV4A
         tj74Qxmq3v3pmHn5lMg7GSakf6+30m7iybApB8Gpo78gTZdJQ1d2rEaf1rcrG3QNH9Dj
         dcHw==
X-Forwarded-Encrypted: i=1; AJvYcCU7HqOuquYumDpq3MWUA2MJiMESAFw72CTJ+WycvtA7oj3sCYMAQod8V0AmSu/6j+Vj5o0wJso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhJ5w5+ByyAdlS9eL8h+VbyPN3wzmO31Prymd3s/5A+vYUeHU
	6AWq3QvDJxNvcLevGmV0gkaBY4e2zIls3UDv85hDgORP/daJUNkftp2Z
X-Gm-Gg: AZuq6aIbNaPjv9k2oCvBQTSJTsyWPigEJcISCarvZhQ+Hx8r5zlwBqOXrgFPiKgNCW1
	agPztlbNNb31B3vKA9RIlj40oDdQ8CvsL6Upl7/LWhr3n07aDM9V4vaqlch56uP/PD/RUvQjnVO
	D2QzzVIqtnWUCy7IGjcWJMZ6Mce/rg0mRur7kUQnn0TJv/5MIh9NuDEgZlp3AZnKJpIaIvFJC6z
	FNFt35xtS5CQc6BWBFDCoc0fBYRp22ieHRSebbVs3ziqi+fbmDMh99vleAtmvavbCaPjAlxpGpf
	kAemojVXnJiaS3mQuwhwBiU9/EwZ3XhsCFS3yxQWpfmuRUL16k9AtaT1uXkWr6idvtSSIMJsJXq
	BIHli4EVvEiBaOQA975eZCMUVsYCvOhnkuIWKRZWLsURpiheU1+sw2l5gCRE+1Mp1b7sZ+w/z4m
	RAOdb2tBDQLi10/aD4u5q/ysq+anBf9Y8Nh+NixfPdmafxiQQOkq/l3CHu7eVdKgB7h5YVTRoJH
	3qeo1tHzDUL5NCX9KajB8uFvvt16l1uwEICpp0KyRU=
X-Received: by 2002:a05:690e:408a:b0:646:b1f3:aeb2 with SMTP id 956f58d0204a3-64c70ba3c7dmr277466d50.3.1771558725713;
        Thu, 19 Feb 2026 19:38:45 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22eb2059sm7927069d50.10.2026.02.19.19.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:38:45 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: cem@kernel.org,
	djwong@kernel.org
Cc: brauner@kernel.org,
	neil@brown.name,
	jlayton@kernel.org,
	amir73il@gmail.com,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] xfs: Fix error pointer dereference
Date: Thu, 19 Feb 2026 21:38:25 -0600
Message-ID: <20260220033825.1153487-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217532-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B4321646DC
X-Rspamd-Action: no action

The function try_lookup_noperm() can return an error pointer and is not
checked for one.

Add checks for error pointer in xrep_adoption_check_dcache() and
xrep_adoption_zap_dcache().

Detected by Smatch:
fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
'd_child' dereferencing possible ERR_PTR()

fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
'd_child' dereferencing possible ERR_PTR()

Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
Cc: <stable@vger.kernel.org> # v6.16
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
v4:
- Add blank line after closing brace.
v3:
- Add dput(d_orphanage) before returning error code in 
  xrep_adoption_check_dcache().
- Revert xrep_adoption_zap_dcache() change back to v1 version.
- Include function names where error pointer checks were added.
v2:
- Propagate the error back in xrep_adoption_check_dcache().
- Add Cc to stable.
- Add correct Fixes tag.
 fs/xfs/scrub/orphanage.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 52a108f6d5f4..33c6db6b4498 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -442,6 +442,11 @@ xrep_adoption_check_dcache(
 		return 0;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
+	if (IS_ERR(d_child)) {
+		dput(d_orphanage);
+		return PTR_ERR(d_child);
+	}
+
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -479,7 +484,7 @@ xrep_adoption_zap_dcache(
 		return;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
-	while (d_child != NULL) {
+	while (!IS_ERR_OR_NULL(d_child)) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
 		ASSERT(d_is_negative(d_child));
-- 
2.53.0


