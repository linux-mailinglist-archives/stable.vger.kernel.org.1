Return-Path: <stable+bounces-243958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iANUKlN5+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03B4C69B8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E82B3007B9A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A23BE15D;
	Tue,  5 May 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foz6b8ig"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E93BA239
	for <stable@vger.kernel.org>; Tue,  5 May 2026 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957198; cv=none; b=Gt3Q24ckKAsaZ5mJPwxEqS3aHg3gUavpA+e/LznB4gpYk88rhypyM9/O7TovfV6npF2RRG14e3I7X+9P+OpKnsgAoGUPZ+AXU5DKXFivtLloLLucM/gKZr01AK5F6Fef08VXamGsWIUL/EHVzGqm9JV9Fms62UZhsyt1iYgX28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957198; c=relaxed/simple;
	bh=VFdrAZoVLC4fQhDueHQHa6dNg4khUzfyM4bGbZqKHNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcmKvEpP+ij7ielqvwBhEYjZICm4+gxxGUNRrdPkHXDffYeD6mbkOmxQOhx8CsCwR4S7kwCGvIYHESlPuupOF3Y65iFOJyAJwMjx98qWkLcLPU5FaEVjX0pQF4ql0L5BPt4EoLt08icCV9ZSOeWN5ZAgcDTyUKYCQncbjlcUA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foz6b8ig; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c15849aa2cso6505544eec.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957197; x=1778561997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxAG6wmMi0r6jkkaHKyUSCVdOHZ9UsxXPZ5kjHekB/4=;
        b=Foz6b8ig/extUdJxsormurwIUn2OXhpGhmncEDlGWg/rM+PbbN0vrCsGQQv9KQAoDE
         hXZPaH5JVga2C1nX8NR4VjjxKdrOAniBhkAO05U7AFWDY/L9Py0zMSOs0lbKVG8H/ht5
         k9D637yUjDuigqt3kaZf1ZjlZRbWfVG7efO8D9Qk91JeIdraWmAnAuEFmqLupUqrwYJj
         X/i7XNWHB/vCONLxEY/B/CFg5vYSZUYwaSTE9bc0NqfctgkAXPczN864MGmcvICT7WzE
         4/bZ3NiqW+fIED5OfpHWUEYqQLTSPOOJiSgsNHCk2Yn/x6c0AXt7EtX8LFCYPIzJ9XKR
         rfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957197; x=1778561997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxAG6wmMi0r6jkkaHKyUSCVdOHZ9UsxXPZ5kjHekB/4=;
        b=AZvsLF64nBthz/yE7B3X5XtBvYlm3p2aCxFBXvg6g/vMxpO13aCUSkPnY3PoVW9+V8
         7hJwfsL0In3KQpUbzcLzH6OpU2nCJSCbXNuZztREa7yXxcjA6gm/TpaxDwEvY5sJ0sTT
         EFwBUx3aCCnFaj45xxzRSSDNwFGvmd6WtcjWYvLU3eoOsEUjcka1wqLyqqBnXDY+TQkG
         0kKqZNXppkUHmj0ohHBs0i811zbqECmhAMRIqa0t3o1kXLYiaetstc8bIMVVp1OsHMnx
         TfL5s//myEQ4/Pwsongj1J54ylWAe1GrmnVwHeFvGrKRP0j/olSOjkWc4GHisewZoZnc
         Ldtw==
X-Forwarded-Encrypted: i=1; AFNElJ9ETRbfpqE2xIA2gMUurPZcm6WANXtUOWxoF2Qx0lvyXkndsTH+dHQ6TPUxexyQuQZ4O1W6zUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1xkiwI33grjjzDAZRpSH6kWRPJlOSJKwvqMp28cyuX+waflk
	BEFJ0ZJ11vZYQjrt9YYhPR7XFTVpAvSIsbhu5dUMx53PK6tLv+kcN6Pj
X-Gm-Gg: AeBDietxrOtCP64+cAQP8pcjq1c+hY0HvRTQSa1BLWWAs5v2TvddPGNHHcKl54TfDmg
	/YpzELgPErNsyC8Hsz7ggTLwG3es0nsdU3kCPwkGn5ppl4tXnNMNDKQMfs8cdERkShfoM1aZuUK
	MhlmUsueXe2m+Ht4AGr/FZx2+9jAjVMsXTYSnC5mvZvn3gynoQoc0r8NC3jjqR70IA7RT2PRK8f
	Z/3KAczwK9/n4P3QB0jtbKP88XL1ctwaiQBq0NUUOGPVSHGGlONRkQzcG0VdeF5nMa9uADc1DM+
	M+AAott/PY2HZ04omBnx7AsgyGfgN/pyDuY37KwMmaaSh3YzbKUq/cw/KRlsNFNp5+dKPsZaaEh
	O1Mub990Nc4J3uo6X2QITphwxf7l2L8A8+H44w8eC3mCgcUXCeaqFTCj4EqDN1C0hjJBeQjnCIJ
	B52Cj4GBhYyR2+9KXJgyQG9HNNMHS/qDzCJUCsqg2lChOImW6ehSTsZ5izXQGekdq80cyGR/yww
	X/AE8AlBAuwP2wFN0tH6s5XeQ==
X-Received: by 2002:a05:7022:611:b0:12c:8e7f:1b30 with SMTP id a92af1059eb24-130b163f8bbmr900233c88.2.1777957196554;
        Mon, 04 May 2026 21:59:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.21.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:59:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 01/20] Input: rmi4 - fix register descriptor address calculation
Date: Mon,  4 May 2026 21:59:31 -0700
Message-ID: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F03B4C69B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243958-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When reading the register descriptor, the base address is incremented by
1 to read the presence register block. However, after reading the
presence register block, the address is incorrectly incremented by only
1 byte (++addr) instead of the actual size of the presence block
(size_presence_reg). This causes the subsequent structure block read to
read from the wrong memory location if the presence block is larger than
1 byte.

Fix this by advancing the address by size_presence_reg.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2 of the series: added a bunch of new patches.

 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44db..06f5e3000cf0 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -594,7 +594,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	ret = rmi_read_block(d, addr, buf, size_presence_reg);
 	if (ret)
 		return ret;
-	++addr;
+	addr += size_presence_reg;
 
 	if (buf[0] == 0) {
 		presense_offset = 3;
-- 
2.54.0.545.g6539524ca2-goog


