Return-Path: <stable+bounces-119831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA5A47C29
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DC53B876E
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62222B5BC;
	Thu, 27 Feb 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDMGQrr/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C122A4D1;
	Thu, 27 Feb 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655609; cv=none; b=JLUCFdPDoi7OlmYcVhw5Z7EFROJaLRh85UZoFRtoi/i6cbQ2AdRmr3SOlCdF4aNITmTeJQhtQOBhMjevDX+tDlnYACNj/ty+CWhqdJs4BjxfNChUMCXmbiCQ7eyvuqijDoBf8pI4dNBD0c6jSggBD0ZpFEUwQGECEqNVFyqYDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655609; c=relaxed/simple;
	bh=FMpXiqpUI/zXzi5rJIh/eUiVM362dNP74vRTM8Q1nBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4E5Mqv2gbGcmGbP8CPGE8j/XMmLBxoOJpIufTpUtjXh3YtCsXtQ/FBl4QxRQV2m86n9IiDCFUE6GQiwf5qjLlOiGxSNLwkECViEaonXldCSbJmThZF2cbwGQbIjIxLivZw+b9FGodbvwPnOKL6bhmgbGX2ffp8f+1DPJYlGR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDMGQrr/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43989226283so5398365e9.1;
        Thu, 27 Feb 2025 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655606; x=1741260406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzhB95Zqrj1l/JGFlbyZnRK9nIprx2MccxoZER3gCCs=;
        b=RDMGQrr/IQDKgbmAc9uBaq4gNbiKqNjJ4gpJFbDT+grwXp9xQ52JVsa/GBzFplxwns
         sfpbOtc2+X4fOcYjO0fDQh1uAVxU3F71IX9oz+oMZPZGu1O/+VT8BwIg70KGiMhUNL47
         KKE7/tmSDuIcJ4WaxQsfo2lGr6L/0/sz4zg8GTU+gRc0+SL6crw6vHXM835ODeqO3OwU
         P5s/PoAogsnWcvj+qUOVkR7vVEz+bUleTNfA2ZUIrrEVH5tlTCW+JnF9x2UHvu5md9iv
         PH6d9P0S5mEix46Ppg/37ZAcZJMqkM98qLn2/BhtFdAxd3T8bhDj/4vSoOWHYmqTltt0
         J/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655606; x=1741260406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzhB95Zqrj1l/JGFlbyZnRK9nIprx2MccxoZER3gCCs=;
        b=V613/xe2okaDLWM84IAGioe+JmzMFhJ5NF3yt1lLKfw5zH8dZQqMehKGW9U0VzLdel
         Py4+En7EyPuFR9jn175rG5GycGI3VEnfhryWRO74XGcTDRIRwuENXACpS3bQVoRvR+a0
         NVZNEcXGiwqzVQ25AksDgrkj86JfZKkTnyW1UvBEWncqvN5FyKHtBO09oXDCwfyFaC2t
         Y/8mJ/k7QsrCvV/8QY/W5NEYFd+wmyxuY12qt9nMF6dAucxO0LC9vAkwZQy5/4mP9rcc
         kbpAjjEvSBQ9TeobH8B5dt0zSM5jQCuflK0NwVFRobnJCoTdrN9udpRjfDJQP+WgIogt
         G9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXqrIZeh9DAErlbWTkVf4kjrZM/GZfRufIQS9md3Osug3MWncBlvRzQKFbu7PXSL3AOJM6XIPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx022ptg430DzuJcirEU4S4GobstWjb96EJv0ooAKE1hVCV8S8q
	bf+/6ROwITevPTeWC/4hGRi3qq99FK3CkNLzZkWT0s8fFsZGgdC3
X-Gm-Gg: ASbGncu4zmqK0ZuzyPzSMhp2mnXOGg9lh4HclpOfORLegd66dZ15dZe39CMkpBzFqfN
	q0umsGuynXX9DfOFPpydyhKsCpVyqwyh1j02FuETH/9aJpDHbz6rvMmVFvWdL4B8xkB+nc9tPOr
	ie0LqwNkYfVZhetwWtY2DsvbgckbYGbi3WRKdXaDbQ2rZrt5mECPp52tZQa9IKUCVoTl2FT9Tzp
	JrNpApi4YR5FZaSJ0OLA8wrTNhi9lZVwyM2C8iMAREHRuYxjIZPa8SYiMM+wjrz9qP45zuGMfQL
	T8euoMgD6sb3MdOt1rYYJo4l2avw3npqJQl/OwASS9XD/VErM7vp8HCtswxhgu37pok2TYHGj5K
	7hMST7Pr8onyAElj/drk=
X-Google-Smtp-Source: AGHT+IHfx9C5t30YwWEKS2WmNlyNZGIAyGXRE5EKV1/linf/ejTmELWOe9r267GP/1uvPUyDHpCNyw==
X-Received: by 2002:a05:6000:1844:b0:38d:b325:471f with SMTP id ffacd0b85a97d-38f6e9474bdmr24154701f8f.15.1740655605830;
        Thu, 27 Feb 2025 03:26:45 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm1757685f8f.50.2025.02.27.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:26:45 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next 2/3] net: usb: qmi_wwan: fix Telit Cinterion FE990A name
Date: Thu, 27 Feb 2025 12:24:40 +0100
Message-ID: <20250227112441.3653819-3-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
References: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FE990 is FE990A so use it in order to avoid
confusion with FE990B.

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 287375b8a272..b586b1c13a47 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1361,7 +1361,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1057, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990A */
-	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
-- 
2.48.1


