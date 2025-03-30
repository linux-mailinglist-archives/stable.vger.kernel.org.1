Return-Path: <stable+bounces-127016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B2A759AD
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AFA3AAE17
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA81C3BEE;
	Sun, 30 Mar 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZq1OoZG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A4158DD8;
	Sun, 30 Mar 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743331904; cv=none; b=lJZkqlBdAHaUhqY5P1Ix5Z6oQeCopg6c/aawBXA+/PsO5pYgodXDLsIyrvUnwb2DARH5gv6T9bMeoKIASeE7c8HqN4Vkv1c8MhXvdRuM0wANgieFEgl62JjbAdLYyArKowrLWL1b6ZScz0UmJE31YAN4RvGthcLKfFup9rNWXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743331904; c=relaxed/simple;
	bh=Q5P7NejdXbV1XiS/42ah2Xw7ZPQQT2Z6dbh2accinlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4Yg5pyzpv7M1xt2SAJuCswmAqcgWbBmz4aCpGCfeSHgURQSDwnhvjGq1HqatQVuS50MwIm5xhg8BWAIJnl7hH7e4THid+qlhL+AAFgprHCD/03/A6RtR1EuKhWuyDVCkudFVBt6jHowvYL/ZhFZ94un4ck2XGLAwp9RK39Boxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZq1OoZG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223a7065ff8so45297965ad.0;
        Sun, 30 Mar 2025 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743331902; x=1743936702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Dc7903aqUi7QARvZQkiVZWl5zvBm3/ivRJbwdI5Nw=;
        b=AZq1OoZGi85SbGoSpfmRcywNI9PIryLz2zRNRGKKhIbU16/XHMYLgG2iceJmYhsuoD
         f8sGY+CmicE7eSPJk/eiRSrg2HfzMiwEc5h+EpPApEkFncTIUl+oW3gGEj/kvIe1vguY
         tZcrgZsTOCZ5WW0di2NAXlp7IZpHTlXaTzyF8KBWQw8nPt5HxdlbsSPQt3+mRcT3pebj
         NhjUHxw931vCMrCyKMc+2He6C+v2sA8PAuszxKYBf0mdpxpg/WYzWF5ahzVvS6fLT/Qp
         EDIxzI1edGEFlLpYpjbTDMT8f6hRGlWTgqyI7v+HnK+P7OQyN0cVW7aGeFIXRvd8DDs5
         6mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743331902; x=1743936702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Dc7903aqUi7QARvZQkiVZWl5zvBm3/ivRJbwdI5Nw=;
        b=Bhi9tLTrvhMoZg6hqqp2LVr1lMlogLI/FOXWCLry54ddRxO1dlrhcXhnbDGkLs3zIG
         UbdWikFxPnwel+soL+jzSY4MgAaVIP2TNiPU2wTuIr/b++6GJaPmGz0BluRrQqAALWw6
         8IAq+4djdjUFkg/EGSrCFd/wkU6YsCkwnR2Rafn3tUrGHKd7vZW5VarmilX3geguVk+C
         WPdjgTvu5EkN6r2AzTAWZGy7I0jtwuPVHgzLyVvQPC1fg4ZX3T07fzY8HzPrLZcXkXVL
         QX8OgFNnrwdaiNa36vV15HdcdTbnBiCxZP9phev77A7Vq1VGwscFyMsUtnX/S8umZ3AT
         Tw6w==
X-Forwarded-Encrypted: i=1; AJvYcCVJFHWgxMZdhBo87eTj8kWWzSPUkV1Fk09o/pPSU2RoqJUT0YIKuDbZEHaiKRFvXB8UyfXrMPdj/e9KJCE=@vger.kernel.org, AJvYcCVR7M2oNWEnIdepKKwF5FoO+GIwHbeEbkx4El7ig87dHH3DcuMiigFdG8hn630vaIvhThHNrFtPy53zKp8e@vger.kernel.org, AJvYcCWCXw3Frd9ERzrludfXxxNyfheZKBO29rke5LLwB/OKZW27YvV/Gm6C3HTH4HK8/ooLi79AvXjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnVcnwf5wmQYT9Rp/g/rjKIO0LvyPP5AoZfjy5FSZPx+8LFlw
	/m/n+bZJroTV/ueFJmza23ff2gFxvDBqLKkYhmoxpQYFCV71jr/I
X-Gm-Gg: ASbGnctUJvKHZlRoEpQ4oVu79HGnUbc+Vu1Xiizxg6uVSTFb/1mr5BuydBTpOqK7Df3
	RCMF/PUukIdwyGd0jPz7yZ/pyPp72mKvxCY95SQQYNlINZ9SJwrib9V0+4MlD8OFT6FhZ8RXE3r
	DxCAV329bXnXvq3VdWN2O8Shg45LDrzNstT2aGb98QsF5BXXdTw6mPg4BVH1o+aPfNyz0oxmVhn
	4ykx/2jIkApAw7GK1juEyEmBq6Z3jIrZgLwYan9EM+LBpzJo1+zWzFxnVJWan6vzOgPt8rejaoG
	TiBj9MXyZ64cOEZQ9kBWExOzUx84cQTTTPWiKr4cw2zaUBhV71Fzf9a+J9L1MvBX9vcCRhQo/bh
	GtM39WSFQs2vlivfzakhZ9zLSLXpio4CpUhyxf+ROdw==
X-Google-Smtp-Source: AGHT+IGlynswCVf1Afq+yxlrKXxYS9eorTi2vj1TP03egLwpQVeJSiv1lInIOi7BBKDsQVKxiyXUiA==
X-Received: by 2002:a05:6a00:3991:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-7398000b471mr6908974b3a.0.1743331901818;
        Sun, 30 Mar 2025 03:51:41 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e1d922sm4991601b3a.37.2025.03.30.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:51:41 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sun, 30 Mar 2025 19:51:35 +0900
Message-Id: <20250330105135.389827-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025033015-blanching-pagan-db09@gregkh>
References: <2025033015-blanching-pagan-db09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Sun, 30 Mar 2025 09:30:27 +0200, Greg KH wrote:
>On Sun, Mar 30, 2025 at 10:16:10AM +0900, Ryo Takakura wrote:
>> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
>> The register is also accessed from write() callback.
>> 
>> If console were printing and startup()/shutdown() callback
>> gets called, its access to the register could be overwritten.
>> 
>> Add port->lock to startup()/shutdown() callbacks to make sure
>> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
>> write() callback.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>> 
>> Hi,
>> 
>> I'm sorry that I wasn't aware of how Cc stable should be done. 
>> 
>> I added Cc for stable but please tell me if this patch should be
>> resent or if there is any that is missing.
>
>Please resend a v3.

Ok. I'll send v3 shortly ;)

Sincerely,
Ryo Takakura

>thanks,
>
>greg k-h

