Return-Path: <stable+bounces-40008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D888A68EB
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E021C20F5D
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC621292F8;
	Tue, 16 Apr 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg+aTfS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FB128804
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264328; cv=none; b=ZWUCk8VSJ6FtWX2bkyC4aLvqH8nvkGrF2HzHTdzuGaKvVCHz7fwBabAIHtmBHfqXkKQ7s+1Pbf/XemT9kF5Qvy4Ucg6c67GD45GNAjT1CaZETCu1INpSYq0XlnjlIfX5i4DM7N8a7N8XMfgq3N4DjF0gyuVara4yDOQx3Rbquek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264328; c=relaxed/simple;
	bh=jn1ryZV2lseU9K0OYgA4GJIVFoBB6E4nLhtvlmWlSd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnYAE/mCWGl+PbPJyQKikHH9fZqRWhTNVZUFRASMcrWnP4IFR+bAVw1I8Mq2XzIHWcFf9ONez3+YbJ4mtQbLGX5onedUn9ApcZHgclkT8GFmx/vx7OV8FdbGZDwPlEghCV3tyeOX3ex5qAwLvXAOa7DGup6ffCZtYJGTWycW098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eg+aTfS7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3051369f8f.0
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 03:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264326; x=1713869126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qw8fuXLn1BipxTXGJjzIm9TXoIt9ndz+hzAX+iGey14=;
        b=eg+aTfS7nKZOR6jhieDT1+DVfxHyiFZjefsYxPPa0gUU9Kb3498wu/3uNhQyA1CDxw
         RNgz7c9LdjiodNqYoV1F5brRqFhvFGeSoPGydv/2xyT9RZoM7BTOpeO0ktvbK6ZsXt1E
         x2KPn6fVx5UzvKDIiqJW+tdZyLxN78t0xHQNSWTDWpjIZp4wW+470V0oE0Rlfm44Df0K
         0PnTmsNblemzUGpMOTFft/zIEblzIFICwDUOFfr+wZXWVrW7DJeZFCNZNNO36FNLfokk
         CVtZmPHVUDjRQs4JjXheyJcGyUUYebgxDVQhm9Rfgx0W2ThpEuq2n3QGYiTM2XIll9+r
         nJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264326; x=1713869126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw8fuXLn1BipxTXGJjzIm9TXoIt9ndz+hzAX+iGey14=;
        b=kz3qWc8Yffyy4BMaFn9+farORz1r87PFzVuWIAquV4MHp5xOJAchzz7KVuk2xTVuiv
         gPPUi3xLg1QQaymgekZJMR2DWdFf9QQcaFd06HDDPBXbMdUopTqjdw1k90S+rHjlzK9G
         dR5QNRgnDGw4rWiQyMfRXZV5XOfLtdfj9q0EJ8fOFvfa2jd1XAvevbKFDejxFDex6Z8c
         iA2ikRCfVL0R8QzkTmsCg62k+fv/6m+RA01HfnWuxPbIaszd+wV5KmXWCfKZHs25eFLk
         Y2UzTBOHfi74u1hTB8dsOynVwCl9XuC9SvonownrXMLA3a7/+pwFTx88VFBVQC1BJBFC
         68OA==
X-Forwarded-Encrypted: i=1; AJvYcCXNiuzWE4baOoFbf2zkAkdfAzeJJi0OP9mu2wBbA+FIhBUsCGA46brCeiJV/Ck6for+o91rOFcJ0sXkZ+JUP8Id/k73by1l
X-Gm-Message-State: AOJu0YzXBDNTImlM6PERF+iiGiJiIUhXPi0luJwumIseeal7uSL7au8D
	F2qPcy4rZWu7ooCT4zgK5yEtgNe7wqI2AS8mPRqo1fHyfUfrQTDzKe/r63ZNP7M=
X-Google-Smtp-Source: AGHT+IEkKrGI1w3FZWu0NvjNbI56P0aC7fTieG2Y5zpD0wRzVFCxdwIhDQBiZNI+lF1oAhflsZo0ww==
X-Received: by 2002:adf:f2c4:0:b0:347:f94b:94df with SMTP id d4-20020adff2c4000000b00347f94b94dfmr3255688wrp.2.1713264325736;
        Tue, 16 Apr 2024 03:45:25 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:24 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:20 +0100
Subject: [PATCH 3/7] kdb: Fix console handling when editing and
 tab-completing commands
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-3-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=jn1ryZV2lseU9K0OYgA4GJIVFoBB6E4nLhtvlmWlSd4=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlZ5c/sK6PaiUl1WqzpDtZN3BjukmuYcg+TaJ
 oiDr1GCb5eJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WeQAKCRB84yVdOfeI
 ofLXD/4xVew6HZYrS28jTX94YhhCHkyLF7uKVGu51j294zh/mIX+9HFyPjgAu7r3BMfPNqUdB3g
 4L9SlWdDtGyZYatWEqIgsmy/ngHQiyeAu2CiMD6UEzwLy/z2/Lsyo8JpognhjaTlnaHOTlflrLa
 PRlOhMg6hTTAIkovLaomVCODDTKPMNiQfKWJhsjnl/D+Cfg3tBrxioPuh9xBoBjTmgjbgOUYRnB
 0Dy0neA0kX8KLfsf2NvQIh0HEn+QEl/0GIO/O+YeeQVyD4P2UdapOF1OB+k/E22gq7ySBnUAz//
 sr1Yb4mOz761ymuPwvB3o8we9r8Mq1lr7OQCWi/F48pqlmARRX30EIjLNiIieP348OMWNYlpifM
 TgpHy78luYFBHup8CC8JN1wx37FV4pgMEdU2woUw/skDslMjzjpqEmlVgq0LD5N5BvpOkj5C9uN
 +NyKzsY+bN1x0g2NxtRZeMceSgnkdIB3s5AsFqNE2xsuOL7T6jia3YMfaN2RI4DN4yVUsMI3W2y
 hSKFRaCshA5yxURhziSS7ECutPW76a5Ib3QVYi7NWtHRv/YoRtQH9jAhr7Cpnwuz+nuFhXzzd6l
 v060LY7GCrjrLNtGl8OJX7u/8FC6+z7o8XdirHHuOA6LLGQVGCe8WkwJPkmS+rNRYrAgJd2fPMH
 LErhTOsrlxZ8z0A==
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
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a42607e4d1aba..69549fe42e87b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -364,6 +364,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
 			len_tmp = strlen(p_tmp) - len;
@@ -377,6 +379,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


