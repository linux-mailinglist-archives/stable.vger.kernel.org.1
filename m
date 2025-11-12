Return-Path: <stable+bounces-194643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD5C5485C
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 21:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39E52349178
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00A2D8372;
	Wed, 12 Nov 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0arsX7V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576C2C2357
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981011; cv=none; b=R6qvGxctsBUDCaYABPERrFOfRLkccSwenfopd9xXLCrmfvfygzem0x5O8Tq61rLNAGDrcUO+amZufGK1Ajuj+gMBgnPaIB7ZBPStaWzGuHSb/WFN5aCc5KuxQ6uDbHkpF6n8kTWuJAqNv6aqZsRLmg+CmefiWl+jhnaV9ewfy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981011; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+qYo+YA0RoAR0pJJayo3aOwUyqWnbi1o0cPpN134GFwJTJ0vdBLaXt93bHjsH+xUcrtKCcwAPjC+TlHpVtGEkISXAdYzKneKSOYtS72lwLeRIW2x4tCeCIh9dnZDSiqUCGFpZgNorLBjYP/sajq77ZawIHljLHGFssziUmXWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0arsX7V; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3410c86070dso61122a91.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981009; x=1763585809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=Q0arsX7VXS74KfwKSzL049/prbMte8lukollavQbPUR+Q2nMG9wiKy9EAw+tbT2TqP
         BbOXQ/Wgmpu4E0FogMm2NB+HPG7URHdRKhelWxFqj1RGAN5EiuFrma7rJjERgbvb7pQu
         S3TWeJhCnPLzBlSmNqh/N01yPrI8chA3GWqUjA2of+bFhYKCjsoTG9xzpludKWILIjDP
         WJ41qYIMbk5Kx9DiNGULcM69+sJ6mpb75B+dP3frl5Miu2zUy08BgqGjW+5gIagoNjqz
         6bJBEUb6azD3hOSlmcdi22T7exW7xy+0P1SBBcBL71y2mv+Ux5iDl8IN3b7ImvZMyR5u
         becg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981009; x=1763585809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=u9VpL2X/iL3A1IidZaepOS4bXFevBqhb9kkPYhC5kKz5+QHk9adf0nmHgwM8L/cbOK
         uLR4vb4fQx7l09jX+0oOnmjorzf2EbFh3WtpD7Bp9HtnFLlUx3eKtHTunnjNsnv6KVw7
         v5gbOJ8A16KrNN5xFpOmmrxvEjrS0CKdWGZnQiRH6FwVftVZQn2wHdd0KPDaVRVyoLm+
         P23hgmnNcl0CXUVNTg0bePLvQR2z9y9ffLPS1aX7ti0bZ/ztE97IJ78QEUhOt9hNMPqN
         oQUBK03gCO6Iqym/tjSV0kMntlfdminBg+2h4/66LTwwdLBDKL1TbmMdJomUrnVLo2DK
         +8uA==
X-Forwarded-Encrypted: i=1; AJvYcCUmdI6F1LBfq5j5MLXuIxeZvqKHoBrTW7uFJdc0+WsW5ZqB85YpYNKRDbV0LtV7lxn64a3ysiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlN4Gp6fIscZCjfPpufnVIZ0MFs8T+kEksy9YV9CGXsvXKa/M
	ROSW7fniZzvqvnF9L73WyVr/vQxtQtT68S4NuIpx4nyevWBjTE9/drSY
X-Gm-Gg: ASbGnctGfqo/KRobQgPyb4cHtcoE+4dfJH+Efy8xPzNvpmExBgc5+z7Qjk4z40O0dLy
	XA/dreZNRQz/vQjj/X8RNyOCocMZwrQzOtAQfzX0T7HSFBfJqJp4/tKoZQvGLCJZjbJT0nalv/K
	B1/14nKp3RxhdQA1j4u508XEUuEqRKl/tzWCexLFvCCDqlwYBZSsaLGotyUcC7utVyGdUkiuIPz
	xkZfvI9cokctCysw/iXHa1pwqoqdYflwAyl+0U0IHxZbsLGBTd8TEfVWuL7TJdc6TZSiN4fo9wv
	xb6rKLvgKW3+uGSfEwcdHwZGGoqLVignSCWFSK1MLW+NiaXe+xahiEtQohcSOh0U1t9IH/MQgmL
	VLQTXNFla4RnDM5yXv0CxBfaPeTmWUHVdo+FmrWcGLZ97U3XMRbdsnnP2dVpQBkoldifjrsJmMm
	xk1eFv3cjiLR3P3MfW
X-Google-Smtp-Source: AGHT+IE2fgQkfTD0gRJw99RJWxiwbFp4l27hkS6vTDSReOBDj42MRuxQP1iVXicme5fnrFTgDr3jcg==
X-Received: by 2002:a17:90b:3885:b0:343:6611:f21 with SMTP id 98e67ed59e1d1-343dde0febbmr4302742a91.1.1762981008917;
        Wed, 12 Nov 2025 12:56:48 -0800 (PST)
Received: from [10.230.2.0] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e071571fsm3599170a91.7.2025.11.12.12.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:56:48 -0800 (PST)
Message-ID: <f93a4dc9-0969-459d-b767-5feef0f5ed90@gmail.com>
Date: Wed, 12 Nov 2025 12:56:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: nvme-fc: move tagset removal to
 nvme_fc_delete_ctrl()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com, james.smart@broadcom.com, paul.ely@broadcom.com,
 justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
 ming.lei@redhat.com, stable@vger.kernel.org
References: <20251110212001.6318-1-emilne@redhat.com>
 <20251110212001.6318-2-emilne@redhat.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251110212001.6318-2-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

