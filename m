Return-Path: <stable+bounces-211854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JFoIDXjeGlJtwEAu9opvQ
	(envelope-from <stable+bounces-211854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B697733
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB363303D333
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A230B53F;
	Tue, 27 Jan 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V6NWrQ30"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0E14A91
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529718; cv=none; b=XEuoBcpZ9Iy1Ix7j0gXUkMbah+rgali0TXrsPATd/DZQBiPYfDBpaYVM8CgDegOqgxTAtFzycwXoC9NqhHizmeRB14BTn4hLWaP9669/nvv89sBpmo206o4heQ07zKuYZdYdg53HBY7gGzvSlw7gtV1Oob9OD2wNkNAkmiidblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529718; c=relaxed/simple;
	bh=aRNTtmrFXwwdWTzUJgx4njg+qH3SbOpxZOX4dCM0ONk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdJsh8jY0TPDI5kRcgrlD30T/ZsBjQjJTG/RodUGlgCbnaGNnUM030LBqoXwNDsp6CIcoR37/640MTsezOgBJBON4T3dOfdsVwUmNglp7FiYrptBUQD4XNHif4dfzhD7XVY8aOu4CSyo5H4KNNY1e7y8QVW67U8bh4jejnFZQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V6NWrQ30; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801d21c411so31280825e9.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769529715; x=1770134515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZGd8/NahD7S+WRP+/5ujNkkhDXmmqtDAZ/rLlzezOY=;
        b=V6NWrQ309gQkvOzk/WvTp0CYOSbaAZfrTqe7gXFLvfkEyKfEwUaLwbGp5nXe/9mHMg
         vrQPUTOFLekh2UkPbaFqaltcBIAtskQLFQ5w1T3DIKCM/3rY8dAWH5pLgyWUiPQTNgJJ
         akWF8g0jsBXK9xbwe+/z51NlKyws73ihnsgrITINBL9+4qR56+xCAvnlMYy5O9mKidFG
         hRoo2ly0e26OW5cwK8oevLQCjuYwHuB4WKHEv0t5dGxvkQMPr4G1aDz13HzqD06uWNoW
         bqNCwlm022Kute4fx6RBIZ9wvks6cYwIEUIE/ldhdbqwsuzlUduM00Oinj+JJ2lw0ZCr
         xVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529715; x=1770134515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZGd8/NahD7S+WRP+/5ujNkkhDXmmqtDAZ/rLlzezOY=;
        b=Qpq4vCx85RhdXuFkV9iKEm9UYcbOeeCq+bGpmHUMASspK6pd807EQFCDWp9Rs7Jsh4
         7gqIG4ukGbdLw53aGj/MNpkBf/UjIGlEuCbsx4g0L1EklTZ+mLG30MAhteZxn9nCDByV
         dspwmD/4FeqYfNR/o3vZ4b+63cAKo09BAmMZtnl7sljVmppapg0oWcoDcoXFLGl/64L+
         RuweQKhPmfrzxgGMpAm985a3EIdg0hFMO8ZjS/4ho2rmJJ1Yo/OvAaYkQrfUIgdlP0PB
         YpzjNX0f5fIiNWPMj+G9VxIfFLzHuO/49upQPFZ5A7uFNvwqTWoHJLkB0kr1AHiyhPr8
         451A==
X-Forwarded-Encrypted: i=1; AJvYcCWUAaIuYfqwl9ufyc9gEgU4AYZiyyyJ9u/Fqab/yOqnXO3G0JDoHG1nIRtsyIl4eFDhAeKch04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFhByNWY/o2ZLQxczGXSUavVGyQU3iGQYoPOEMaLHGeNPa7pS
	V75IMV/yVpSWYi8I1iMsX/zonjCXncGuNcwkASYt/snLUISpRgdUrwMtPRstKZ6diH0=
X-Gm-Gg: AZuq6aJztNv7NH2goX5uPXXJ1oUuTP5Xgu6BbEiD/NueCvvVJgwCIVeLWIOXcZKZ3Sa
	hQrgiPbui/toP5onEwvwbfkVJ+sFP5pH49x7BTRS9HmusHZ96yIrXlCK8WXZDjADHdR7Jq4QgX4
	i8NclOmitILm1EEIru1adWsOMaQDz48uyM2X2tly82ZDHRlZjH+IVr8tuNqJiBzod4dQ5136Ocg
	he91eavbIiuxS1ZvV9KbsQOUhcxf0Q2qH1K05sg3pUVGs7SZicYOMs3b3SAXKua8QKH5sZSRoPV
	/4x7Lz98hbtNNGbxcMWFrMtz5F1Ti3E/V3QLerMwaweVrIrrGzWm80o3X9KaP2NPdRh9J0Drm+p
	OSZsUNdZ7DXKnenBSW22fbl8FKWOylnLRruP2X22WbPCdw+ZoeptDj3/y7UUzurcy2SuobGWVLA
	LgLi0qFXzLjUhaPTGmGbvVeQEOLMaYCD0KU7eW1to1cjh5CvM=
X-Received: by 2002:a05:600c:8b03:b0:480:1f6b:d495 with SMTP id 5b1f17b1804b1-48069c5fb04mr27151185e9.32.1769529714991;
        Tue, 27 Jan 2026 08:01:54 -0800 (PST)
Received: from precision (189-69-94-41.dsl.telesp.net.br. [189.69.94.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1c52sm17470958eec.16.2026.01.27.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:01:54 -0800 (PST)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2] smb: client: split cached_fid bitfields to avoid shared-byte RMW races
Date: Tue, 27 Jan 2026 13:01:28 -0300
Message-ID: <20260127160128.243441-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-211854-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: CF0B697733
X-Rspamd-Action: no action

is_open, has_lease and on_list are stored in the same bitfield byte in
struct cached_fid but are updated in different code paths that may run
concurrently. Bitfield assignments generate byte read–modify–write
operations (e.g. `orb $mask, addr` on x86_64), so updating one flag can
restore stale values of the others.

A possible interleaving is:
    CPU1: load old byte (has_lease=1, on_list=1)
    CPU2: clear both flags (store 0)
    CPU1: RMW store (old | IS_OPEN) -> reintroduces cleared bits

To avoid this class of races, convert these flags to separate bool
fields.

Cc: stable@vger.kernel.org
Fixes: ebe98f1447bbc ("cifs: enable caching of directories for which a lease is held")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
v1 -> v2: Add Fixes: and Cc: stable tags

 fs/smb/client/cached_dir.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index 1e383db7c3374..5091bf45345e8 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -36,10 +36,10 @@ struct cached_fid {
 	struct list_head entry;
 	struct cached_fids *cfids;
 	const char *path;
-	bool has_lease:1;
-	bool is_open:1;
-	bool on_list:1;
-	bool file_all_info_is_valid:1;
+	bool has_lease;
+	bool is_open;
+	bool on_list;
+	bool file_all_info_is_valid;
 	unsigned long time; /* jiffies of when lease was taken */
 	unsigned long last_access_time; /* jiffies of when last accessed */
 	struct kref refcount;
-- 
2.52.0


