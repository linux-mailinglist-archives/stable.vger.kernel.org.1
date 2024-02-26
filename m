Return-Path: <stable+bounces-23609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B642A866F93
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67BC1C2581D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E95810E;
	Mon, 26 Feb 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h8/+EL5W"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E85730B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939905; cv=none; b=WCHBsXOF+y61GlHLhYo0B57gjU7Tor7J6zp/7jlIBr4Qjds41tv3YHId8t42pDaIiZ9KGZAHaKZQMwYpZkcAReeMktKMbX6j0NXXh8sgTuOcoseSBH9Ck/tSS4uYL6PC3fRw2lz5hbYPJTTRJaaGbMSDrW4ABhnnkCn6opVKv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939905; c=relaxed/simple;
	bh=oMwEwBsS9LpqWFkXQJGn/wGr2D2RG9J1+84Vl1zgefc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhWuIgnFcRQQWWWDpgDwexNA6rqLTmxlUVQGHisYvqo7XJkbMHC3Ep6nQjuPPRIy8NfrMPV+Z20HX0LASscevK/DY47YILIt6Yzu+dgtKZAjUz5EghtxshIAw7vg8hexNM7019Wo6Qf/sAXPGZTRzhK8RyJtABZivjXrNQ/i82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h8/+EL5W; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36524116e30so7664415ab.0
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 01:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708939903; x=1709544703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbQaXGx202MYUih537vCjMC9neGAB2aCaE4Hy7lgplw=;
        b=h8/+EL5WaBr9GK6/F/s/38m8F6UPwXXgldRJNPunHwVbQgr7YDpsL+koRonuYQOul/
         damgjLUV6PP+icnzNGeOiYhYQMuQlRmU98phonhhrDhONbGdJe8JKIWDlj64w+vizN95
         PbMCOgQVK9GBXY+glMwDuRLeM48dIQJFXFcXmTCwjfMpoL2y1GEECBEkR/l1aCXLklTq
         2RWUyKn2PNcntDiUnZLh64sAP60tElQdBBEmrzrXQEuEjeBaeN5zP/0TIiiaQfn4QBbG
         74alzU/YFPbTZ7KVYymJT/8EjZN2CSkpU9VJZ009aMlFfg0NeblxpQFx3qf4YOYbhxPQ
         78SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939903; x=1709544703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbQaXGx202MYUih537vCjMC9neGAB2aCaE4Hy7lgplw=;
        b=NVIEHVr6O0lpsdutZs6J+VVdYIZ9ihsGEux4Cn3WPEO9w1gu8RZldLUWyFKJDzBjhf
         31zq8tO3yh3xkHy/o5l3yu5DxVg4z7sF+K5LbjXtsK1Q3NxGMyJk6c0g5/sCfO4kqafd
         4TKGWkJze2lWqE9EZKxBhzPVP/GQViNjJ9+lSiDLVPRoC0lB0rxZzsqoEIaCBCc4idKY
         VULqYmmtwQoNK+G6CRDCpfiU/NycQVX9MaQ2P8bAC45J09Sr1vRCs6DiYFU5acif/6p2
         I+h6KnjKgO0CMVCa086D+h75XFH7q2wJqoT+zR4cSZSTCpZQZER0IxU2I2w4bNY3nr5N
         s7tA==
X-Forwarded-Encrypted: i=1; AJvYcCXKMMFFEV3ppGKvNbHiGr5DxZEYpgi+VMOdfnTuNyDy1KlO/61Zid20xg8SlwZRwLEAkjsc+dJw1m6LyoVhDSqqnxfZPEdD
X-Gm-Message-State: AOJu0YzlM+3MdcI57y/l1utLQ15l3kIKMjYTTKAdz/NQ/b5kxpUr6ttr
	BNIUAmPM3tVqcKN6x+KG6Usbi+JnfrYiFHv5+w5/395x0aDjjof219NeAsA3Qrw=
X-Google-Smtp-Source: AGHT+IEmj3b9nZlpJaFO3EymrQ7Xj9BGLomqh0QQ/h+wzTZtX70NSEYzexvpQN94Fv3ml/LFzgnoDA==
X-Received: by 2002:a05:6e02:214d:b0:365:bf3:60e2 with SMTP id d13-20020a056e02214d00b003650bf360e2mr9636330ilv.6.1708939902818;
        Mon, 26 Feb 2024 01:31:42 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.14])
        by smtp.gmail.com with ESMTPSA id z6-20020a63e546000000b005d68962e1a7sm3539555pgj.24.2024.02.26.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:31:42 -0800 (PST)
From: "$(uname)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(uname)" <$(mail address)>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	qirui.001@bytedance.com
Subject: [PATCH 0/3] Support intra-function call validation
Date: Mon, 26 Feb 2024 17:31:30 +0800
Message-Id: <20240226093133.94909-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Since kernel version 5.4.250 LTS, there has been an issue with the kernel live patching feature becoming unavailable. When compiling the sample code for kernel live patching, the following message is displayed when enabled:

livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack

After investigation, it was found that this is due to objtool not supporting intra-function calls, resulting in incorrect orc entry generation.

This patchset adds support for intra-function calls, allowing the kernel live patching feature to work correctly.

Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.2 (Apple Git-143)


