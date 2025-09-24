Return-Path: <stable+bounces-181560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C2B9805D
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 03:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7B2A09A0
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A471ACED5;
	Wed, 24 Sep 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSddFd4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96102AD32
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678453; cv=none; b=cPoWke87ozF5GGQa58hWdxNc6EozBJwE/1SWcfTccPSX+vIE/k8UevHagnY3LV+fBO+aPM/wdBWZtX2h6fDg0+XPOALC3Ln35s7XuuQiJYVG8gDQ7OIE8JdfQ/4jV0T9F5gz/1AZmiiLgzp4exCQknGBONzqfwzpbek05hCAFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678453; c=relaxed/simple;
	bh=kqwBAp8eLZsgM9ZcktYb+i+BnIyf5jtMDwEu8f3+z9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nx7sk5k71ZN1qSOnRcqZo2rqMrTwdO06QIG8Da48XmhwYzg0BjTVPm0eKkcerriWyh62ODWiJitAFCD1AmvPBye1Py42qiF9AHik2CH7c/6BOP3EV0XVJx8fZjmpbuEen7lvbDUbxFLE3KxUDbYc9bnLf6yLIMWVE24ss26rJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSddFd4O; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso3915704a91.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678451; x=1759283251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+63vGgkh7UGktsCdsW0b30BT1FgIBWocMf/422wjyPk=;
        b=lSddFd4OmFCfNlVIBcHbF6OsZ2Crt/leCtSwjR9XzjX2mp8H33z1eQCtgkbn/I0xS4
         Xl4CxK/iqd1HI83lRi5OAz0TGwhWux4QPaw6aoAglvTRKcpggy5UP3uQy6o4h0y1oxkX
         Vbr3T7GRoyqVY4PzyX7nY+396+8WO4SlKY/S/I+WRgvQDKoHGcTb4M6KZb1US9MzQaHn
         eOtSxMNJIEg1eVxN/5FH3ugwHcqUSdJaaaMbo/B3ufbPoWs/TSpK+cxdkSxKcZdfsNZY
         j4bn0cATFPuLD5Bl7aLWSVsmHHWo1OIEnK9KKip4py8WJU6q9A1TY7baZibvYhMWHQcj
         snug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678451; x=1759283251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+63vGgkh7UGktsCdsW0b30BT1FgIBWocMf/422wjyPk=;
        b=V6zpPovZMcn8dRdaZ+S77gc3gBpynWg+eNUfddKa9T3APIcOzCfgv/XlObd7iQw2Q9
         8Dd7JuX9xyDwe61eqFm2CpNzbwxYQLbU6T/SeXsUyOEES3RXJrORtycEyNjbYviRJGuH
         nOHUSTcW4IRfxXxEOdCr/KeC08AZJaeeB3NzzNmRsqRmaDw/gonWPkEP9DiRcayq7wZb
         j/PLmJF1KEQ0AgHO7CY7hqJ/Y8mrnhPAngwcPU6K0Q7pTcsIZLQFTENfUdEb/MNcjEtq
         my1uEwYyDy7ZyuGDR9uX3/dAUA3yHJfdYlK5EV9RTy6Q2/5cao9tEpxv5yR1PylMZ60X
         r5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhj2ONAmw4sD+soMFNVGYF6BS9uVNfPTwa9QzsjibJS02IYRibGvo8g9HQ3BaEx6jMFd5GJvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilIfCpuFs0QmuAgDCFKweMDyZlkU0SY7LphVPVg4SzArKHh5B
	t2cxPlPzdpFyQlfM51ZC6fHuwgvbd+ujiy4cHLQeCFHmOac+/VaLfIcu
X-Gm-Gg: ASbGncshpZ6aP3XGIzFfyeWYxn+Lcdn5fAA3EZBDaqRHBlwXBKGrJL976qi/VgFlX7e
	Ri3noENeTJm1ewpjYL5zF+tP5qBLN07YiH6x2dkm+doG/tl3ZEq09PTrMFcNTNrPhamjTzYLa1X
	tSBI7xJL0d+TfdXV1AiRVyWnatzeSe/kBlNHO3ugovAHGb58zwH9kzhgVjOuMO39BeUi+S01ANq
	KaVXUWaCgt3RMQxVipmiZXqAUibk+HwWoGAAFsEZ4HSJIkVsw8Dlmoj+gjvt5de1vY8/tLsY8EX
	Iw8GFRVg1KrWZKlFt4cJB1+UoNNDDc1n9vPrblFuqrjBwSYWlM805MVu7EPkWS2NaJxlUWaw7ts
	bnFTNNV7kys0fkcD5OKhCNsTo7seCIwwpetGYF2JbR8rapI/ju9FFLthRvmgDQ3cje0H88WUZaI
	VgYA==
X-Google-Smtp-Source: AGHT+IHc2+qV9YYa2A1zqzzvMJo/TTQJFOQUqQLdGHK8ky1h+q44otSDbugHv2Y4fcEMBtquunjYCA==
X-Received: by 2002:a17:90b:5448:b0:32e:37af:b012 with SMTP id 98e67ed59e1d1-332a8ced9f2mr5577212a91.0.1758678450981;
        Tue, 23 Sep 2025 18:47:30 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be384c5sm483599a91.26.2025.09.23.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:47:30 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Wed, 24 Sep 2025 07:17:24 +0530
Message-ID: <20250924014724.1097866-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The comedi_buf_munge() function performs a modulo operation
`async->munge_chan %= async->cmd.chanlist_len` without first
checking if chanlist_len is zero. If a user program submits
a command with chanlist_len set to zero, this causes a
divide-by-zero error when the device processes data in the
interrupt handler path.

Add a check for zero chanlist_len at the beginning of the
function, similar to the existing checks for !map and
CMDF_RAWDATA flag. When chanlist_len is zero, update
munge_count and return early, indicating the data was
handled without munging.

This prevents potential kernel panics from malformed user commands.

Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/comedi/comedi_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..786f888299ce 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
+
+	if (async->cmd.chanlist_len == 0) {
+		async->munge_count += num_bytes;
+		return num_bytes;
+	}
 
 	/* don't munge partial samples */
 	num_bytes -= num_bytes % num_sample_bytes;
-- 
2.43.0


