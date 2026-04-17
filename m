Return-Path: <stable+bounces-238430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FJe+L/3W4WkuywAAu9opvQ
	(envelope-from <stable+bounces-238430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7A41783A
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5FA301DADC
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0924351C07;
	Fri, 17 Apr 2026 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev6IYT5V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C332ED27
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408297; cv=none; b=lWpyzxJFWU1PYrGNjYlCf8C9dDLl+XdNnubTU14SH0qEASpBvMENqhOTq8KBJCRy60xAZ+WsT6i9DQ87rhC1KqIGzbdIcgU9u0TXIMKtQZt2A5jYRNOXnez9mK39HrEWhFJpmsgvjMNcp31B4AMJMuJOCDz0iMP3hx8qchj1ID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408297; c=relaxed/simple;
	bh=idu1RW3ysteFFCmLuOlQ/aqPD4nZPXDeX2QMvTFnWME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTsLqye282xtI0D75RBC1czK0rPdLo8mWjoK02qiORJLerV2L0NLjz6Y2QOIC6joe8UHWxdO+/jHzC8432win1+HRUZ/RRkozLWitc/cRdIqaUcEZl6wD35THfbuWqlTEGr2gpGkv4Ii0dzD0SW+N2BUu84YS4Ttzzr9uMrAb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev6IYT5V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so63273f8f.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776408295; x=1777013095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idu1RW3ysteFFCmLuOlQ/aqPD4nZPXDeX2QMvTFnWME=;
        b=ev6IYT5VopN4YRDxbTkc1wPp3JUhTfWVoiH8qLW+tG6nzBmGegi8RF1R3nxoTXXxIP
         OpzVZ8Bxq4Ddp7NjgaZMgt3YyqwW4wR5jN7DSij1UHbfhS5ODmCZmLnxDS38C+kFOtL7
         hSksOqpxKVbZaD2NeDCcLPZFaMVPOgBCfqAYt7cM6AWpIyU6ANxEO6XL/YvyJ6nvZd9t
         nDZr68PPByOMr6HW3tti8TxKK6327O0JxabzuWyRYTQAMZBw+ItXuMFkRdwtYX3ugwbU
         Jd86DHavl50pH/7egDiIgb+JrEMhbg38eIXeIL0D+OSbjefkBqIDtSr+qUwQOa+fXs0Z
         VCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408295; x=1777013095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idu1RW3ysteFFCmLuOlQ/aqPD4nZPXDeX2QMvTFnWME=;
        b=G6gh7zM+AxX5YxKmvVuhScW8gYgwhWfJiBDwlmLKzUCBPQM/+JCjbchhhPOJEkE0V+
         /8f55wQEM1xy+II9BIxvN40mXwKS6+AwxTr4CexLaPr5VTBJtwrY/O5cB7Exhy4SowL7
         blmmh7MqGacoBn73622VcSb5yTaMJfe0oIOGwEBNQ/h9eDzbIA/usAOS20awAwQgERjO
         1IeY3OtqrVziYnB1GNUI+DWEn4/WZwxGdHr3d1vyGj4s2Ce3bfK6no+jxt6ecA/qgCHA
         +Yf6i15Q2HJ9Rgg9Kok6RKhSYIAc6/f8j4SY+MSEWrcsRvViY1zoTGY5Kj9uvHEt2CEa
         6n2A==
X-Forwarded-Encrypted: i=1; AFNElJ9brEsIOuSjIkodl+qnxGT2ZjGzLCUpF13y4IP8bISDihvgtEaXYPjUppdOrlAIlnj706wX6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IQqPIpL8rd9o1/eQoSeWjCLb8fIpMpBe7LXMAh7lBn82SUAG
	Pp6GkjfWjI8Pq9fY7yh5r6rkqXSxzZrrapf5rNjJSSWfIUp2eCr3xKMy
X-Gm-Gg: AeBDiesh2ah3NP1QZbAni7H8EnT5OJe+dyoKk7bz5+31nvgjFUEyM7PgpELQxRFqpnU
	lUKG8rOzM8JGYK0I7c/8OaoloKfwEM6l2qluJeB4ED/4c0Q7Fdjgm2L0uAVrVXRppmay0HSwoQ3
	b6zfKDq2TAUfhb7yiAwPcjdldbLPwwPZTJUec24D+BsTOfN/6anXU2CBhNHCHEOH3cJbFUFDEwt
	LslK3jHR/jHlnOlJiZjp37U75bY5xT6eP0DT2oB8dO8WooujZPdf1JJD8B4lvB3m3ogBX+XHUCi
	9vrf7wh+GpaybPKsyoKtOthIjbPhD2jkUX/mFQpYTpC1KT7FrvpJOJGoocHuKg1RTcbhPwaNjSc
	OrR5+/4lJgfEE1raVRWoETBt1tgZkSCcuE/3aRqJWXSOFV+xtz6CXYPurQ95EZl62asPebvFEBA
	DxKdpTBfmNIqJXyV3A6y7L97lgBJn2Yw==
X-Received: by 2002:a05:6000:24c7:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-43fe3dfba40mr2145216f8f.23.1776408294517;
        Thu, 16 Apr 2026 23:44:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a381sm2312517f8f.21.2026.04.16.23.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:44:53 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:44:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 0/5] staging: rtl8723bs: fix multiple security
 vulnerabilities
Message-ID: <aeHW4iigENNqmdFL@stanley.mountain>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1CB7A41783A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


