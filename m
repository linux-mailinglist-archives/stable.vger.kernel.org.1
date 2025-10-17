Return-Path: <stable+bounces-187701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CBBEBB96
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1FE44E98D0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF9269CF1;
	Fri, 17 Oct 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnIFHLZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADA248F4E
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734117; cv=none; b=dRO1DkaqzGHL37odppxpHpV9WTr/Cj7bIRnVXqzfrX5/8cN0H0DA/OtmPkiJmfu/PkafnmiZHV3zh8Q1yeTqGG+aPKU9ooev6AQVK710qsIp0ufyB5v9QVmt7Pr1rHG+UfdgEqO0WkdLEhNXODGqxsLHmMI0UQbpjx+lwElHqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734117; c=relaxed/simple;
	bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEv++JUYPS7pnAdpcby6pWdgmTQ1z2W/OZNPK1zyq9liVbFexGUk55PuN0ja/u0nVskUIxaYWZrO6kgbipvJMOeL08xzxtLf2eEk7530vDk8+2LMPbUz11KVcunHxryMxkngxidVBnRGZMpa1iA7owJ4Po9zw7QB8J7vBLELBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnIFHLZZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so13692405e9.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760734114; x=1761338914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=SnIFHLZZs7YhF2m0vcAe6oe2xSQE7X5HerxWIZHUhyYeXUfr/vpSeIuV2rCIv4Ej1Y
         ZvCk1M9UfrxvmkrBhjvhTfzrpcEjQ5i31aiY1TEDK9+gw7ES+bcHEB9K4Qv2ZL8lFwau
         w2onrMDpEfDdqPAmxo0vDNbqdxfCYANz0jtb22JO+be/pGGXtDJbiEhV/qr66XMN/Xi3
         qaVkTy6tgfAXQs1ioibH64ugtYfJtBOZPzPUTpkcUIpSrZjsL7yvUQDdeHjCTLlv+kp1
         0TghXFfBor0vE/LkNvPq1EqIl92DvkMBSS8QuROhu/tsu/pJEJFPAn4nSNSLPd9Ffx5z
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734114; x=1761338914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=LpoMGon/c1NbNC/HztOp1SBOrKW6zINPR3sj1l2GPPLXGLzW8QZDtayMRXljFpdUnb
         qggCFHQkAb6QiNd2KC9hQjRIpGQJhrx8jPBqk+RexLcKlJxnUtNOWAt8/xFQ29B5mOM8
         dkyrWQHULrro6UTaaH2ksWXgz8qET36w2eAh5o0bEg0Zvr7CBFSM4avXPJxBxLf7z/6B
         1AIYR5azzq+uw13sWqUvIclFnecJROCZ4cIVKp7F2L/8tamitnwvUfIZD0YPLyTlD7BG
         aBxJCGS5WoSX+QtidlLC5sjdcsbAxf7gMJcttb1rfC6X40p7Uv9hRcr0R/mOQSGbG6U3
         5sxg==
X-Forwarded-Encrypted: i=1; AJvYcCWu63pgAgS3nLN2KlHEM30T2JG/FiXPl2WUfMFm923/WTraWaoF3x+j3jIQBLj8tf+U6fG6ZWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3NZa6f3BmhbgymmqcFy8UaG22qV56fXP208eN/lwTvoEn3R1
	ivIRbx7EjktrSXAKQI4DUVyFOcDJ93OK2PjoMVHsViyt8imtzxzfasenD02T0bYfVW1qrF4z3ia
	rn9l1cbgrBvgTchCXV8HHkOfnBpOeerY97pcyUKl5
X-Gm-Gg: ASbGncvP3SrRXyA15o0mqckLlmz7vYWr8bkdxNsH4NIyldfVkPX9R0NC6EBiYpVzTu4
	3W+5pKZwn9Vnr5UnvQKrgP19tyTGCte+UxwPJ+2YsEyo63sadRUYMMDPIhJrHcpGHu26HTsH5b/
	BSsgL12KryjX0JV1oAwHaOfis0eoC/HKRWRSBip3xvlwhfVZij+brVcPhD+lC9P+mZ4DApcWpBK
	FRl8kMJMJSXirwTVC+kPoH4y2s+7aFm8Rg4BT/aUGA7pTnHcoukGu3tScW51v6ASbn4yuc7Co+l
	2gQgVDZZrG72fYKWmePSPlE=
X-Google-Smtp-Source: AGHT+IHAavia4dajmjd1wu0ozenk/EgHnS13fnhiNCGOo15GBQoO3qzrk0f46KUvjIzbKPhJBuIwwZghoR1ZvbV+ZV8=
X-Received: by 2002:a05:600c:681b:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-4711792a6bemr42023365e9.37.1760734113965; Fri, 17 Oct 2025
 13:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017000051.2094101-1-jthies@google.com> <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
In-Reply-To: <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
From: Jameson Thies <jthies@google.com>
Date: Fri, 17 Oct 2025 13:48:21 -0700
X-Gm-Features: AS18NWBOVLDYxDh3NOr1aYj7ImsXftnVZMr0nHmHk5U7INnmD_I0toUf4vs0lBc
Message-ID: <CAMFSARdUMJ3WX1L8U-2k1w7kmH8Z4y7=MKKEBjCmyY-94wiBig@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
To: Kenneth Crudup <kenny@panix.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
> Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com

My mistake, I'll send up a v2 adding the appropriate CCs.

> I wonder if this is the reason my (Kubuntu 25.04, FWIW) system will
> sometimes show the battery icon as "Charging" even when it's discharging
> (or nothing is plugged into either USB-C port)?

The update to set max current to 0.1A for BC and default USB operation
landed only a couple months ago. If the battery icon issue is a recent
regression, it's definitely possible.

