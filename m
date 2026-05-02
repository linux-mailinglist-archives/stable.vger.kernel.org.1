Return-Path: <stable+bounces-242592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH2ENAbX9WmyPgIAu9opvQ
	(envelope-from <stable+bounces-242592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 12:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D04B1B35
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226433015732
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECC33439F;
	Sat,  2 May 2026 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLTFQYUI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3F30EF7D
	for <stable@vger.kernel.org>; Sat,  2 May 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777719033; cv=none; b=euMP1NdELpL9DdR1c9dvcFwWM6mErgwr7xcEl9HwPAEE9Kvm9Thr+c59ohUyGnIHoCTs6YoylcD1xcJ08AnTqex51VQzOKWmLcagev1bJejSj6z0mzKcXOIfCt8+/NDhBCeaQtV5+la4jCsB76RtcOz6GCR8O2MT7OeUYtk6n6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777719033; c=relaxed/simple;
	bh=T0LW7yB+RCgEQIoEqn/+YxOuIPaN4zMuZoZmeMEwP4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fytJpfyA8q3TqqV6YOnmZhygpMV12oRoBaCsNb9y6C/9nLz90rhBwaca0PsUFteH9nN6E0rs7BbQFBMG0AlC9QlhG30oRTNf15LEygLQWzmW2m53byoPKfENdv8d2rKxONQxFEmxfdHgBJZEaYgbfUAk6ef69rFAvJf7QvH6j+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLTFQYUI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso623510a91.2
        for <stable@vger.kernel.org>; Sat, 02 May 2026 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777719030; x=1778323830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExtEosiCiZz24wtaV6XMqbxMv7x6yLKAIrTwUeohUmY=;
        b=qLTFQYUILhckXeJPwZQz3bRQZqdrUPr1R7CaQIzkjTVKO5e1t59qNtmxO93CFynsZk
         BP2uY65hHHK3D0mjg5/JUhYar9ABGc2t4Af7O4Ob0lF3syHLwPRZWclM1XPgEUpuuGHi
         phXp6P+A1kLNWiz9Z4A0FQlTkgd4uutYL1us+gYMVjZCSX5Iy6u/CvpZb3xWtF9/7lq/
         09/562JFFk6+8DbT2sqgf67BF++6CA88yEyUQeUgb3fluxWk2CGbyt1w6EsjFUt0I3qq
         2ibRi67Bjb8Mw+UnlrFkK5CATWeWyMNzcvTsAZjdzMHTdVcHfJmgIpLw0HXksoRcRKTE
         RoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777719030; x=1778323830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExtEosiCiZz24wtaV6XMqbxMv7x6yLKAIrTwUeohUmY=;
        b=sYlqxsdTyQqwjCZOdMuddIujhWW9ecNnirwguVmZNk69W4ne5xG3kp4Avg/TYC7EZV
         aVvoFSlJ61FbvcISu2mTyHqLbMYgLaU9XD9YnOPywo+/yxiZJQnCD24tuz1AlINi9hh5
         y/L89yvhOZ2FxdRe1toyjDXA82birGT9AjhH8fJLsMhlnt28XCVyjZQOaPx/AHr/ZU3Q
         IAj+13QdweUlhtWtrnx/CNvIbDo4Mjz8150JsYq7sRhr9++SG711BTiPleDVkuzK1YSm
         Rz0zQ2ukxO9+LGIyZr8DgjmVikUovLVvsXYWRb2cZJCmkCVu+m7l785uVLOoutC5/nbe
         JQAw==
X-Forwarded-Encrypted: i=1; AFNElJ/ocoTFzbdCii6ib03iRWQKT3gtkUDfTQQ35VSYWTUmeZTFT79XTOGSX4UP1+u4pdWtkyKZNFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxXX7BMJw/2R0bTtXLCBDB/pLJ4n9yRId28rEKksjsfmX2kMR
	ywsfNDi+IofOI0RaIQV88Qke4MrKiDdLrR9d3D32AScHcZPCyKcrIW07
X-Gm-Gg: AeBDietqOp38IOZegX7ihrOvXrlR8Q4Pu/vmoO+q9/y5dwImT/74kWL7FS49DyKxnPf
	k9j47ySc1F+r5mfZFW7FUeBSdKxjnouUpkxYpkZwZN0CnRtU6L4oFLMQ+sTaV4vF5sFlBi4RiLY
	+sBQJZCir/6dS8YLmzu5jVg4F7RcAAc7gzn9KOEUB7Dc+uruZYc3RbrNeGp8VZEjJr95al0/6xF
	9/zQqumuZmOjtjxVJMvosT0ws6DOtKzUJuR7y9qg433dmm5jA/ywH1OhYWw/XeavOrKekg875tu
	c8+VbwdYxIfRhAftjyrZD+mEzltYLl7YyJNWWpVTzhU2WdiXOoUV+B8eV2JhLPeDkcIUMg2RIwP
	N5iIbBzWslqEEaELWo913nUP2puiw0ZSFTwtXsiimHgOmoz9xyVfKYSBXK4/rd/Ji2icblKD73H
	URgD992rNE8tt464I/sgFOZ4d5ERZo
X-Received: by 2002:a17:90a:d407:b0:362:be3b:c8d4 with SMTP id 98e67ed59e1d1-3650ce10197mr1415546a91.3.1777719030297;
        Sat, 02 May 2026 03:50:30 -0700 (PDT)
Received: from kali ([103.195.202.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbf298sm4482616a12.13.2026.05.02.03.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:50:30 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix Out-Of-Bounds write in log_replay() via unvalidated data_off
Date: Sat,  2 May 2026 06:50:07 -0400
Message-ID: <20260502105008.21827-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 704D04B1B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

log_replay() applies UpdateRecordDataRoot and UpdateRecordDataAllocation
redo operations using a destination pointer derived from the on-disk field
e->view.data_off, which is a 16-bit value read from attacker-controlled
filesystem data:

    memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);

Neither check_if_index_root() nor check_if_root_index() validate
data_off against e->size. A crafted NTFS image can set data_off to
0xFFFF, causing memmove() to write attacker-controlled data out of
bounds of the NTFS_DE entry and its backing allocation.

The same unvalidated pattern exists in UpdateRecordDataAllocation.

ntfs3_bad_de_range() already exists to validate data_off and dlen
against e->size. Call it before each memmove(), bailing to dirty_vol on
violation. This mirrors the fix applied to DeleteIndexEntryRoot in
commit b2bc7c44ed17
("fs/ntfs3: Fix slab-out-of-bounds read in DeleteIndexEntryRoot").

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 fs/ntfs3/fslog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 272e45276..c0237f7d0 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3487,6 +3487,9 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
 
+		if (ntfs3_bad_de_range(e, dlen))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		mi->dirty = true;
@@ -3679,6 +3682,9 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			goto dirty_vol;
 		}
 
+		if (ntfs3_bad_de_range(e, dlen))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		a_dirty = true;
-- 
2.53.0


