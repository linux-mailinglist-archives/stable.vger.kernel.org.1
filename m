Return-Path: <stable+bounces-254301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJDYGH95FWrHVAcAu9opvQ
	(envelope-from <stable+bounces-254301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B862A5D453E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F38030078EA
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153F3D903A;
	Tue, 26 May 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW3m6dBe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4E3DD50E
	for <stable@vger.kernel.org>; Tue, 26 May 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792018; cv=none; b=EzXlAmgbAoxEwQYRQAjbzTD6n+dsODZ7QReWL24Oliq5ivDAVb1EMg1XRYADr3W2ihhbrWGQHuBmISckvknVhY0e+zWgSnyM26ZGVFce+QIYm/fK3kENIfrOcFRsRXbQVqS7s+NbBGLcZY1QeugAuu35IKlRnqcKR+rxuJ3XrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792018; c=relaxed/simple;
	bh=Bls7qHvIUDoc4ooazcpfeyKMHkmvPOvpEwus1CeH7IE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kDCGVrXLwTEJIJCbMru+NRWn/3+byUjwMxFTQeeX6qOQ0AWPUodWTROouuTp8Kcp2V0/qx1kj0Q43S49ixL7W5SyhhjiFHMjwBwj6264xxhfW7QsMfnB8lMU7eBvw+QxjBZ0b0Xvv0l40F2jLmh+jCRdvzbjw9PRBgQkkiQtl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW3m6dBe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd0209f25c1so1606505566b.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792016; x=1780396816; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqXUGLpT1dA9YMKXdh8DEtG5timDuzzlcnIySkvCiMY=;
        b=hW3m6dBe8kzDKImHo26fgifDzfp/g2QvQLGIXq6LmVzFLu9f+CH4Kwr2V3XHL+juv3
         C3Qr4s/HJU85pS2K9hBF3N5IIBVN/Y1jgzW9Zy7q11FBbTNKEizSlgS11KHzyuUaaf3k
         9SXlLqvoGuL8XB+eMB49KgyuHuJ7v1TKoYIkcrexC4xyjxGmA5CsYT0Vwu3ybsTLDDzq
         Ub1/K+lxIWgnGlt3VUpS68h7HXcMoUK0fFeqDNEy9F703CgtQkdewJ9Di3ydTMvT2u/J
         BsxozRmZFurJOjn02fQHnfCvkpU92uQLyMofdmXMkUqdzS2Y2AIL3+Pmc5ZYfWfUp12p
         b/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792016; x=1780396816;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqXUGLpT1dA9YMKXdh8DEtG5timDuzzlcnIySkvCiMY=;
        b=KjYFVJ8wLOZzZXjQPW6jVt8L04BqflNxGTHbFFLajgPf/IhQZfEcfsuHai2zcLfAnj
         ulUTUXJPH1rTZ44abxUOcLFu/3JTgiwwccSXkNUbKDuywnlKIN9UIfWSB1KkcmqO5a3y
         3v6hiWBxNiPKNgY9LmaNnXRH6JWQ6CkqYDB2cu43No0VMB/ooZ1J78uOuejpjjMR5rtC
         CmOPUpH9aVl2JL0p5BQ4weAXzQs2KwRHxl6+T7Zo+xWB3/ro52r85wjvzGxbyPPNr4NE
         MQBZvZWJVkre0WEYgXgqfwqbzBvg6QC/w04IjzG+opqwvsvfLynduFfj2y+w1urPYjaS
         phpQ==
X-Gm-Message-State: AOJu0Yyd1w3YExGXa0X/TuVD8GKOFnPk+UB65zTz4XbUl2+mqIJncujL
	RgAWrpUd5jPyEyxz8+o6j7zoU5x2/YlanVI6IxSfmmqLdHQxSS0oWcX37n635wmlFFE=
X-Gm-Gg: Acq92OGzoq0FGXuejfwxwZaFu1N+PLKBXR5xirwi9KlQxCOIFidRXKRIBKEXI7oscMl
	lQaIXWDRUotOdLGmFfnpjFogifWTkLI7vePd4W4BXI8xGX6V9Hv2dpv9gGEsM7PnOueT2NYLuxO
	O/q1Wog5GI78Ome0fHZmhd6mDiVosg8p2C8c6M6e170Zb/PyIhoz+QVZK433h2ixOI644IK5yq8
	Kq2NKhOcwwZTDwGwap5tkVKatyGdYBaxJEMsEu6kJ5ki1JiHo09/QNZC+j/QLhjjjz03qQlvKB7
	kT/RpqUnAgRnKvRiKePQWDmE2e9hqrmHOz4CryTnyhi7bTVSonbYwf7FiKa/ItSDsAVKX1Wvaba
	6RqOJNdJQhPtprvaSpyThH6GNVgNi9gpri4caQjOHVG1sJQLTzDV/eGRkVGSDwbM7E6QpDXTncX
	0dinChJMwrN/eXwl036IbJK1KadMk=
X-Received: by 2002:a17:906:8a64:b0:bda:916b:c87e with SMTP id a640c23a62f3a-bdd28b6f18emr790400566b.12.1779792015569;
        Tue, 26 May 2026 03:40:15 -0700 (PDT)
Received: from [192.168.7.128] ([80.242.35.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb139b40sm4764655a12.24.2026.05.26.03.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:40:15 -0700 (PDT)
Message-ID: <d02905f7-6ef8-4df0-bb55-dea44fda6ce2@gmail.com>
Date: Tue, 26 May 2026 12:40:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, willy@infradead.org, brauner@kernel.org
From: Oleg Chaun <olegchaun@gmail.com>
Subject: Subject:[REGRESSION] fs/qnx6: incorrect pointer arithmetic breaks dir
 scanning completely
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254301-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olegchaun@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B862A5D453E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


#regzbot introduced: b2aa615

Hello,

A change to fs/qnx6/dir.c:qnx6_readdir() introduced in commit b2aa615 
contains an incorrect pointer arithmetic (adding an offset expressed in 
QNX6_DIR_ENTRY_SIZE units to a plain char * pointer) which breaks QNX6 
directory reading completely: only few entries are visible, kernel log 
is spammed with "invalid direntry size" messages.

The following patch seems to fix the issue:

--- /tmp/temp/linux-6.17/fs/qnx6/dir.c    2025-09-28 23:39:22.000000000 
+0200
+++ ./dir.c    2026-02-13 18:52:56.000000000 +0100
@@ -138,8 +138,8 @@
              ctx->pos = (n + 1) << PAGE_SHIFT;
              return PTR_ERR(kaddr);
          }
-        de = (struct qnx6_dir_entry *)(kaddr + offset);
-        limit = kaddr + last_entry(inode, n);
+        de = ((struct qnx6_dir_entry *)kaddr) + offset;
+        limit = kaddr + last_entry(inode, n) * QNX6_DIR_ENTRY_SIZE;
          for (; (char *)de < limit; de++, ctx->pos += 
QNX6_DIR_ENTRY_SIZE) {
              int size = de->de_size;
              u32 no_inode = fs32_to_cpu(sbi, de->de_inode);

I can test any further changes on real QNX6 fs images if necessary.

BR,
Oleg

