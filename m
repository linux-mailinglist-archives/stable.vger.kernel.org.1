Return-Path: <stable+bounces-88143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731029B00E7
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271FC28454B
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B31DDC00;
	Fri, 25 Oct 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhihztZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFB1CF295
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854664; cv=none; b=Qs436v7KiLdmdS32Sj8H2IM+qIKgemaWE+lI9g5rDs39Pn05t2GRxprMhF8+DNfjfpLRVpRzNkLDJ5LnndyDN8Q+iH8afw6zMPvY9n5IzXjPD6ZB3DfvpXJ0/cf5roiYtuAVbDuSBSeDvYmlzLJFLi3rN1jyn0hYQ4plgMy7qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854664; c=relaxed/simple;
	bh=DxIfBQXrH1Xs2wc78ePPfc99pKvc+iL/Vx4PjZmTlKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bp1H2o2aN1BwsZYAN7oSgSUb7YmRFYHn9m3VLNbgUUA/dwkSbn1BFZu5I79trizL2T1h2F5gOHqL9D5LZHawHi9jGhGb6JB834ZMHXOuvDzAcmwpkVNoZJFj728KvPsOscSCsb37drHFB3rUR63OpEaBkgeH93DKQFTe/o2AUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhihztZ4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152b79d25so17812655e9.1
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729854660; x=1730459460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAoPtk2p21WqOXSKfb0zuYspiByDLClYh7v/hXTSgls=;
        b=IhihztZ4I2PzXpwUsMxTGQb09P4vAwsMuM+8x1y2oWkI+Wxo2TyVph1obePKkEZAzK
         5K8zG35NJPUsgN/0fp2mrOO3HMYsB5Ehrswn4PBPUFH0AtmdKP+pZsq0QvDGBTOlI5N4
         htHiYdHx3DpAf15XRRLb2aweKK15PiT+fYX5JpBi3VISwEo9IWpXlPMCI6mS2DQ3sa5d
         EgFG8smkr+Q0RqwrhhBil/FxIfEEHVP5jdXUilP1VeVjCS2vUM9X20/z6fumTbnoICnt
         GtNc6D/oOuVFCmA2qrOimZ/7oyqy2t1Z6YYvMZktXjyaA/rdtT33cVJMs4txsbucY26L
         mMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854660; x=1730459460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAoPtk2p21WqOXSKfb0zuYspiByDLClYh7v/hXTSgls=;
        b=s8s7pjr99norXxyfBbphUIUGjf3TE6n8U8Fsc6XTZKePGZoCoe9Z8IytrT4y06LDSf
         8MG2HlY56ykyLe8I3nCw1lm635iy5M4kLzpb0ZE4yFQ+aeJ/fS6KJE6pAL70GposIBzq
         kVlshVzwFaBgla3ZuBHNC7ZDnuJaiYDhGpA+MZIBBUcWyiZaS1o992k9DdERD1y9yiTI
         BsPfXo5LWfVC5j3CIY7P35YlUuG73dIrPSjHLrN58FvTuuIWiC9a+kbJ5/XjMEW+W/QF
         QLUCPhJD4kDpi4gnkjQ5bq81RciwLHK+ll6V4gGLdwAFq5OIFVBFLU6KAUpbb98oBqbp
         BGLQ==
X-Gm-Message-State: AOJu0YzA/01mrZyQz2C6XKZYqKDVDlPejMpaVCM33ppNxRHzFSGhWlcr
	8UQEPSWijIwHcZOqjim5vwgCwh/072iCVPhGDDHI5Z3ftSkjffXkKcxR0MF0Ti2tdw==
X-Google-Smtp-Source: AGHT+IG/0YYWj/RUqm7qrTvoTtb6etksBNoBPudb1cgZpmZ+8h35hB8rREDoRlDuDYt+d6RU5fEpQQ==
X-Received: by 2002:a05:600c:4ecb:b0:431:5aea:964 with SMTP id 5b1f17b1804b1-4318415c2damr78611615e9.19.1729854659947;
        Fri, 25 Oct 2024 04:10:59 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e23sm44687065e9.25.2024.10.25.04.10.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:10:59 -0700 (PDT)
From: Tomas Krcka <tomas.krcka@gmail.com>
X-Google-Original-From: Tomas Krcka <krckatom@amazon.de>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Krcka <krckatom@amazon.de>
Subject: [PATCH 6.1.y 5.15.y 5.10.y] serial: protect uart_port_dtr_rts() in uart_shutdown() too
Date: Fri, 25 Oct 2024 11:05:48 +0000
Message-Id: <20241025110548.69008-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 602babaa84d627923713acaf5f7e9a4369e77473 ]

Commit af224ca2df29 (serial: core: Prevent unsafe uart port access, part
3) added few uport == NULL checks. It added one to uart_shutdown(), so
the commit assumes, uport can be NULL in there. But right after that
protection, there is an unprotected "uart_port_dtr_rts(uport, false);"
call. That is invoked only if HUPCL is set, so I assume that is the
reason why we do not see lots of these reports.

Or it cannot be NULL at this point at all for some reason :P.

Until the above is investigated, stay on the safe side and move this
dereference to the if too.

I got this inconsistency from Coverity under CID 1585130. Thanks.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240805102046.307511-3-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Adapted over commit 5701cb8bf50e ("tty: Call ->dtr_rts() parameter
active consistently") not in the tree]
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 drivers/tty/serial/serial_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 58e857fb8dee..fd9f635dc247 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -339,14 +339,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty) {
-			uport->cons->cflag = tty->termios.c_cflag;
-			uport->cons->ispeed = tty->termios.c_ispeed;
-			uport->cons->ospeed = tty->termios.c_ospeed;
-		}
+		if (uport) {
+			if (uart_console(uport) && tty) {
+				uport->cons->cflag = tty->termios.c_cflag;
+				uport->cons->ispeed = tty->termios.c_ispeed;
+				uport->cons->ospeed = tty->termios.c_ospeed;
+			}
 
-		if (!tty || C_HUPCL(tty))
-			uart_port_dtr_rts(uport, 0);
+			if (!tty || C_HUPCL(tty))
+				uart_port_dtr_rts(uport, 0);
+		}
 
 		uart_port_shutdown(port);
 	}
-- 
2.40.1


