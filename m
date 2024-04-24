Return-Path: <stable+bounces-41363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEA8B0BF1
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 16:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B7F28A37A
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236915E7FC;
	Wed, 24 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcMlWtTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D415D5D8
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967557; cv=none; b=VHBeAXfPbBy/HukzmbogzfasP1KQKUcspzMXWJYQqyPKZkEOW43kRHVVdlctbSSqTcpufLeSFAn+iKGa9mRW2prHi5XfRigwh8TIEn1ZM5sIkfMTXDuOpUbLlT3gM4L29Y9bsSIh3dfNw7vfHvQbYyHUCNrsw2t18viu45oFmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967557; c=relaxed/simple;
	bh=wti5kj6bWe28mBREcjkcFgjgGXuk8vkEPAf7amsQIJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSFCkNEz7QsFbNFAKhpwKgVqcDn2FohQZ51Hg4O+INAStHqeGzjrGUQq4dw/bJeDi9jBY0v3cEhXDfEx3mV02sJJph9hDrzthEfW7RN+w6QxdmzPFdlsT8v6fPgozfAlHwaUq2Se+h8UtZkhPy3vcG7o8xjVYKI4JbMPDj3QB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcMlWtTp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso4952185f8f.2
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967553; x=1714572353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiQSgCwG9Fjd2pIkvI/eNn2TXAIZ8kV9PyuFCdDbFAA=;
        b=IcMlWtTpKNdt7yNtjhY9H/vg/0adY31kwIUKmZvtvLiuCbxMkFr4eRGr5+zShWspq5
         EGm22IODuDxXRWfeU/Bsh5vvjMgQsMl7KO7AYo0YYZI3LGCtp/L4Nhxks4RreQIXoWT3
         6qp47XX5Q9zbim1KyL6jTZc9lBQo7QFWBRSxdzFTh5MVX7TPOeN0C2D/QkS3Lqew+63+
         a1TUOhqUketsJh47MSqgi3hQtbp7mSIpsE2Lgn5cwvKSLhtkxD9DjqThLCl+CP6gZD96
         Nuqwzt2JikgJP3TU6APs6ASpPiw5gr1BlFrCi/qnRaRc+Z16sg1TXyPRPkv+MbFfsAdb
         aZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967553; x=1714572353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiQSgCwG9Fjd2pIkvI/eNn2TXAIZ8kV9PyuFCdDbFAA=;
        b=sULNBjLLZrYFu+iEe4Ot6ovqTARnoqwCDnc5A8nHNvUSIV0KQUqIRpHYDq7cvu0Nyt
         DmqzcgE5lacmc8WadfL1zhMi+1bhUpmO1ah7GalxtE68Pv9qtTfOVLvIY9ttgjzlw4H7
         jfVxDd+xLVnBxBgs14fEiVzoM01alK6mR6BPPrN7VuoZzZ9inOy8We9xuxfjd2870Ba0
         1NILtxQxkaw6snczLajJHlPiviaqg3ItYrYy92EeiZGi4m5dIqWaWXZav+N5HffemHxP
         VSNpwfVCyjAKXKeg5fCSvHDKqiiHW3U9B/3X/EIKc7O988VIfPNpumS1sfdPXcBTdDm6
         tprw==
X-Forwarded-Encrypted: i=1; AJvYcCUCSzbmlRlHI3MgrxXZlIsEeSrvAjW6tu4RPUPFK57gSD6A9d4du/4pxiSQEnyhoiAo4Rs3C7222XXgIwgT0Z58Ru/S2xZl
X-Gm-Message-State: AOJu0YxU4oqWh+fSumfs8shnvcDEftjOBYu418ZVzS79B+TJn3j9SRiQ
	WVmRSk6Z4b+OrHJTsdAwxwSGkKvrnnrIU9vOth3KwuMsvRvSLiblndKUkba/gyE8tg/hlB5gE13
	qhYc=
X-Google-Smtp-Source: AGHT+IGqG2RVeoMAdeMDYTn9tNZggqfDQ+qae44PwKczUO0hg8teOGcUdrRa+KCXGTu719wfKa2arQ==
X-Received: by 2002:a5d:5449:0:b0:34a:a836:b940 with SMTP id w9-20020a5d5449000000b0034aa836b940mr1496105wrv.18.1713967553671;
        Wed, 24 Apr 2024 07:05:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:52 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:36 +0100
Subject: [PATCH v3 3/7] kdb: Fix console handling when editing and
 tab-completing commands
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-3-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=wti5kj6bWe28mBREcjkcFgjgGXuk8vkEPAf7amsQIJY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRF5rcqN5Dgc+qstFjiPAW9G3hYBgyjtuKx/O
 swzPOkiGi2JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikReQAKCRB84yVdOfeI
 oZjqD/43oGbEO2TFmRq3wSCHWMsq9Im7d0XzuP6Xg6OkzQSMPMsg/HnNUiCk/wDXM00xOeKEbii
 4cU4AETV3oDjp6xBzEveKXrybeWohUWm5Xw4A7NBghLtRIxQZiqPo1K5ZFYwEx9wJ0H5bV9i8V+
 5+40DrU28YsTTricP5jKJzKqTQX+JRuurE8td8GTROh/0HElI0ivzakG7tSJJd5yzM+FFiTJTin
 sVuW+imTw06DPAVR5SlUiBPtWOQ/maUdfNmCf1HDz9iqG35YH58o4ld3cn/4WiC4GAEfEQQZKn6
 uLMK5tZGYB7/AjkgsKuxbpGhUCzv9U2toh+zg9Uk5RcJnDDm/GXuYPOFZiEpVErNH+2JFt8CBJm
 n8l8XydEaaFvPUgXY6/wJZ1R5R4FqOsosP9RRdIZK7g8SGek6RUebPV7T+RE7FA3n7uEbdQwctI
 7K91q6CqDsJaGD1PeCm/vCiLKC9mNv66KCVzCK0FDtUfjLP8zLTGYuYbCoKbqY/BRYY376R17Vz
 SYuypvrzNgSz0GVneF5COWavX9vMDvfIaDaYcjiALtgCIIHM4NKgDSzBZsX52dflKFeUzDBPWy1
 5sb1DLSBpau+aa0r7C0Mb+MBz/JAMUMyVK4PXUP9PAfDSgAD6nHQEfoQbizf/PhzwHm+nkgTsJ5
 fAV1buYnpy4dfLw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, if the cursor position is not at the end of the command buffer
and the user uses the Tab-complete functions, then the console does not
leave the cursor in the correct position.

For example consider the following buffer with the cursor positioned
at the ^:

md kdb_pro 10
          ^

Pressing tab should result in:

md kdb_prompt_str 10
                 ^

However this does not happen. Instead the cursor is placed at the end
(after then 10) and further cursor movement redraws incorrectly. The
same problem exists when we double-Tab but in a different part of the
code.

Fix this by sending a carriage return and then redisplaying the text to
the left of the cursor.

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 50789c99b3ba8..5fccb46f399e5 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -383,6 +383,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
 			len_tmp = strlen(p_tmp) - len;
@@ -396,6 +398,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
 			}
 		}
 		kdb_nextline = 1; /* reset output line number */

-- 
2.43.0


