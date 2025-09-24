Return-Path: <stable+bounces-181564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FFB98093
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 03:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2661B20D80
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5220A5C4;
	Wed, 24 Sep 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYNB1tk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF019D065
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678975; cv=none; b=TA0+3+CMizhiibyEMGQY1utIPxUcu3eyxYMLG793V4eCXHd0FclQtC8lFbtCp86Jby2tmpcij2FsXtcZTBfozI9TPaA00Jyw8h+H4Hg1gNdYVLiWeXYGoXxqph53ULG2ivQ1eX85gVl6pxqj2C5v5Bood0mMfsJXXwyN+j9WGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678975; c=relaxed/simple;
	bh=mveThYS13G+7KNQwz76VZIIbZN3IajdbzskP0SwjrSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD3YMYL7P5IhYRxRZKiP61liVohqD4gdALAmuxnjFOXc+7I5oQP1lE9WEzsELOejq5JysTqIi13ewRmI8dzqlh5dFEp4C/Zp4S7PBh/gPUy4kaI08CGnN+Tfw4FpTltLjgxjWt7oP41shkx9SczYq3TZZExe6AACdNZWBvoieJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYNB1tk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b555b0fb839so1665255a12.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678973; x=1759283773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=WhYNB1tkoHRHqtGnBEHiMYYICyRNAey8woMgmBRbtjvlfy3xXrWFbiq4HjjuwretIn
         wfQJ4RecA4UcwU/+7R1vZn+zRbDKelFniXsDeklYetXOLcU/ju8/IRxfM1ylCobiUqhx
         a53bGsG0X+Z3azAQsW5ph+2ZXWG4jh4MBJgOxEW3TRO0ALvDiA9Ts2kbr/D3kHMOhFaE
         chXERV2PrXKWCVOFIBmmFKf7HiIblTxyGTCMGCHEXLNaLc50jhsPUZUnAYFoCuNLozc7
         txEN6wl9iVy+t3X13CMUAmSEtMksrjPUm3zD3sTModcVrKezcru/fWcIKhNK25WaT7P7
         CO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678973; x=1759283773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=KiYUQF+lIf0kFrzzj253rHFsadkEU7GWHQ7U9j1K893E9fWVMEDm83xqIJFYi/p1Mp
         DMnl6M+iii3+KE7KItI2LsXsCP/vM1o3HHyxpHTUYOEAu5sixbjyOLO+k4yMlWcqaZN2
         F3bayoe/TY7bKsEu92OyL5ap7NiiNEYF63M0I2XIjb/BLNCHEmoYsdN8NyqdtM26Gj6U
         jUGMWaKmIy4vfrG/rV4BLh9Acnf56v56M5JP6RL9r2IFYiug/a7kT/yNAsKwN4Kn+piJ
         t8P/EYuo5LcDzYsiBg7G5kNYWSe94ldhwr0Dc87FQCEUcU2pyN479LnoP737ZNf3wgeo
         5QNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTm1Qu7teX/zCbI/wQOiDOkOUv3wloFaIPK/svBBUa6Og7Qfu75u7dEfShSRjmy/BBp6CHzuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbWmPHVn7FOOPhnUtJ2Lvg/8rDRSUBYI4IRuXhBP+GwlRVHSw
	TY7bvBKvhSlZFwmcyZwD8unv1HSZ1h365s71M+UjAUIJ32i0hkcm8KIg
X-Gm-Gg: ASbGncvLac0whQfmxf4B9b3sjaDtdbUN/gVj3GFpAOqmVxjOVJuO0sY36fo7ni6KTIy
	eqjlarSqoBf1dSOCsy91030eiBVKwV/oOWyli1CYXpIUBUrL5eDsgq7HWiS2dApFPyJeru6UOWU
	6ElmuVzYvVLi1EtrJS6t1EfEt51OnNif64LOttclve697fWl8Z0XkdNdhoH4blcNMxH72ep1b+e
	V7AJOFzB9S6LBkM2U5HkL51ATutOBfXR9MVWKAPG0seZsURnhb/UQAnJvocuVlrI9yF3Aum///B
	CaDmQKhV9BwbcTzVm76MQC0B5esPG8yVpoVxeTRlTScfO9BnvtOmJT62e+Oi57l9k4WGC89oiGv
	Ng+nU5ATDDFUKS0iA8m/lNK55ZJm+80GRMlvQ+AxoiE49Dk2ZwvEk4tNaQwk1FieK4ko7Qg6FMv
	gQOQ==
X-Google-Smtp-Source: AGHT+IEBlwBOgeFyu+ftXErZj0XmIMLoGEfVrAjBJfNuSrd7qIFwYoitM5ulTDc1r1vZ59HBSqCqGA==
X-Received: by 2002:a17:903:19ec:b0:275:c2f:1b41 with SMTP id d9443c01a7336-27cc79ca055mr46304915ad.53.1758678973465;
        Tue, 23 Sep 2025 18:56:13 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm175418655ad.15.2025.09.23.18.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:56:12 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Subject: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Wed, 24 Sep 2025 07:26:06 +0530
Message-ID: <20250924015606.1098345-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


