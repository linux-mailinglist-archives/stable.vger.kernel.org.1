Return-Path: <stable+bounces-245371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CqVL1KGAmrVtwEAu9opvQ
	(envelope-from <stable+bounces-245371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:45:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAA518629
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D560302C347
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1402C08BC;
	Tue, 12 May 2026 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9vG7Nlq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963E287263
	for <stable@vger.kernel.org>; Tue, 12 May 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550303; cv=none; b=DyY9Zw1TDZp+zuVZIV0SQhFLo/Kzpm06us1QhKTEsPOkegCuTptj4LDfKi3iOAn0Qp46x/Sg9YqXbNljE1QjNzqOGFQjBUhtEgkWoQy2HqmLV/wFtSE+I7HUU7sStC9CUsujPtQIBnjtnELJxkejO9Q7EZfClVexe1bwZl94xAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550303; c=relaxed/simple;
	bh=CM1/CZ6HdJnVUKbVAC2ZuNemS78xv0T3WdNYnJONcu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eChPQkDpmscC/XtReNcMSz1B3MWlWMLLAo5VZYTnBDAv20zbBL5hH1T/9xR23RmQumEiXbnlDG32U5kr4bd8i83WcK/2VpfRKZKn2D0b0HSakTuDKolnCn8r+hVUmcTuyULIIobN29lH+j7SqTcIVN9P2iWM53aQQWd+NsmKAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9vG7Nlq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so7574805eec.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550300; x=1779155100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zoZ3CghkLfLolXcFlwo+7ShlWPK5OjniN/Ru2vBn9zw=;
        b=O9vG7NlqOekDNLmP3JUnFI2aVVfAq4kSKx6BxEvSeU0InmO45uYMH8koG5wi+Y7ZY7
         DMEqEvxHrqaDPi2d2yJ/UjnBN3ZMjFnCvcCZM3bFPzIVA2RBJbcv64AKIDRbsFvw5IxC
         GhCs5uUfR1uAd7B24oZ0egwaB+zy0mOF2EvY7q/lz3Yn0v+jIVr3H9S5bBMRif+740sd
         OkNVHh7Ubdr+RDdwSeZ6Wgrgy96hbbuKw76a6QBiryksMoQtse41TiDKAbOZVLfeifW+
         i+kPTwPvsWgMvnrEbm98Qxpz5eG7GOr6PycBcDJK3jNGC3pNrZ2XclUdYhMnKI5+RBPy
         a8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550300; x=1779155100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoZ3CghkLfLolXcFlwo+7ShlWPK5OjniN/Ru2vBn9zw=;
        b=B98nSF+jGtA3l+8q8ObjntYQk/HrDfqSkGpHLqQNS2HhRA+/OwJselhFOrlhDMjxmU
         jqYJ3wqFd2Ak6yX49R+Xs2PHVrN9VJ42Ws8i89WVrQwqts8ZvSR5O2TeNky0K2VmiHGO
         aOZsvJJykSis/miT1HxuXWHeIi+Kbj2n78TUAxsH3+OCHQqKV2Mj3SjHb0kyFVepbXgv
         ZGLHNwOSNGi1bhrjDFk2UoYi+Dn7lT7i8z2Zh/WbUC6Bha+7m6z7a2fXyDG3UYebLcNu
         hAgCjFNKfJllwZCVCdmtzVBNm/GHGFvfDYJbcwrQPy6OQhuellXQlg39LTmCbSkFtOvY
         z37w==
X-Forwarded-Encrypted: i=1; AFNElJ+VQg1iLVH53B5zKEYDmC/NV0154oDtIxXr+EEnPKdBNoob6P8dhBLZrgYRpvxrz5SbE6+H9LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2ZWkcurGEPMMJYWq0nABbxObycbsKJf8Dp1dfiOR0w3KfHlO
	mqUOXNRRtPzdJn4nDv/hiAqmHQDJqGPgPOxKvDFUpnYqbEQ0ctsWvkga
X-Gm-Gg: Acq92OFJj5mc0PWxn7trB5JpzgZ/mYpOczLtrjESDsAlt0dAe0Hctp0Zeomocfv4UBI
	/GAX7ITri0cKPFIX0Mr0F12viNeUpBpl9hdyxEzYGl0993ww3pkqmx57YG7ToRkBxEDSAIgU1We
	ynkyBZBgPdk4oBonoc08m9XCyeNRgOUL3K/tXjHaDRTdShEk5qX/EIkFZTH8SVUcyKrLjVw6hBX
	Vd5pTvGJPu+XtpzoVSwM9UpI8yb1/YA1HAoETSbVxXB7+HFgl3G31OfUuvGzIuHriUZAasKHHRq
	4sGl/QFEcqGb1mdvrWnnn+V+QDZK/sYhxCLoXSC8oAIHSgjUwRzntSycUJAn2DEAT3ZhSx/tgr5
	yFQDD27P+9Mzgy4jB5DoT7+vtkzrbaOlNgt9KcgVbAKYZhKARGrWfgaTVxvtXBH46WIdKEh8o2b
	BNTWPSGMeT0WSEHMKA6x8A3inUIK8hPHLIY7c/zsHtqfCFRclfHvrXhyQuiywtp1J5UckfbFa8O
	1Rcduc=
X-Received: by 2002:a05:7300:478f:b0:2f2:6dde:df53 with SMTP id 5a478bee46e88-2fb4b733e84mr6826603eec.17.1778550299405;
        Mon, 11 May 2026 18:44:59 -0700 (PDT)
Received: from localhost.localdomain ([50.231.3.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm15816499eec.28.2026.05.11.18.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:44:58 -0700 (PDT)
From: Shayaun Nejad <snejad123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shayaun Nejad <snejad123@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: fix two remote frame-handling bugs
Date: Mon, 11 May 2026 18:44:54 -0700
Message-ID: <cover.1778550157.git.snejad123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EAAA518629
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245371-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snejad123@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Fix two rtl8723bs receive-side bugs reachable while handling remote
802.11 management frames.

The first patch fixes a use-after-free in validate_80211w_mgmt(),
where decryptor() can release the receive frame and return NULL before
the caller reuses cached pointers into that frame.

The second patch bounds the combined SUPP_RATES and EXT_SUPP_RATES IE
lengths copied from beacon/probe response data into the 16-byte
support_rate[] stack buffer in rtw_check_beacon_data().

Both issues were found by Kuzushi + deep-audit (Sonnet 4.6) and
manually verified against mainline.

Shayaun Nejad (2):
  staging: rtl8723bs: fix use-after-free in validate_80211w_mgmt after
    decryptor()
  staging: rtl8723bs: bound SUPP_RATES IE length in
    rtw_check_beacon_data

 drivers/staging/rtl8723bs/core/rtw_ap.c   | 6 +++++-
 drivers/staging/rtl8723bs/core/rtw_recv.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.43.0

