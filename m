Return-Path: <stable+bounces-161467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD6AFED9B
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C731883FBA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FDA2E6131;
	Wed,  9 Jul 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tfM/00Q/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155E265CBE
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074603; cv=none; b=PekRsRG5UTe80CxdFfFw/P5TsNgbCRqeVpKlSsXExSyhbZISoeW17jo+oY3gIlUIcHozTySm237YAHEf2tpKiBCO2P5Jse0AyywOOtdBtrSayeTNeQkz3lX/4/DoZW3MHLpvwDvRMPa1jpitw8VBqSmmHKwjiat1nm1lbDXWk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074603; c=relaxed/simple;
	bh=xNwWPqmfXox92HseMYI7HIS/IbNrVt1B74JGLKAC26I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR3fO1NoXiGsClvf+TnlkSta0raZ+MVVsgxSjHkzLlomhRRB9jkNrMAxL0652WZnSOHBWhqC+IAA+UnKQSVIs+c+Gl2QkaOvpVw5vP2Hz6WkATHpKMRfAUnWLXt1xORS3OoA1sD2iTwuS+Zey8l8SuaZlzZxgvaZeAH0iZsx8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tfM/00Q/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d3e7503333so864384885a.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752074601; x=1752679401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taKscuAxBARZZVcojDiir7HwGviwhLXve6yI29pYzq4=;
        b=tfM/00Q/tJZssHdpFGe4w/pocrFNZCY55Kg4ExwytRN+Erx21XF4V15vIqVJbAL5Xs
         P4k9lxxYlJn5lvRwIxqKdgNKF2lFs8IWW2Mg3LMo9/iLNTNGxegDpHmmQ9cKSOLW1wYd
         eLK4vpXxwSd6M2y5nFP5Ui7gBbj745vovHy4bu5pYvv+yYPD+UM/VtLUu7FAaf/OXKLy
         xMGh/amc/AKpQyALk+QHLYMOjN/agHxPI1u2cHXIgNghFogGQTxPfdLKp5yX8dFXZ2Ps
         U2bQqN27LxaebdF3j5sBl9H6jFEs6V9kyiyjjqCnZJhj6W45MWOsOwZxXggNxPxHEAhY
         gGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074601; x=1752679401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taKscuAxBARZZVcojDiir7HwGviwhLXve6yI29pYzq4=;
        b=ICfjzkwWK3TxfBWe3EuT5av5Y+rtLiDCpd+7HrP2qTlwKM2xncaLEdbSeZ0M2Lpi9U
         swFs9omz/MYTmDrtZlu1iBMh7RAVZ3Fi52ZOykT9w3qSBTsqN3DrwEkciAaihzDvmRLg
         2Zb4XS4fdNCTnvYK1GlUzQurnc5EwpmtLqg5mOPVa2/qpxAAdnWMs1nnvh6uANLZNonm
         5vZU7tHgdO/KAPCMKLRPi9x7rx6Bi7AcluWCodgDz6O6fdU6vlTNPq1yQrYEwKJzumAe
         rgfwOpIjlTiAOvB4Ws6D8Bc+jRadeqt+Ys3OddcNRtZULLyKKiLkJJ91xFMnbKxhmiTu
         k7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DaCkUuz5je45uoXX4MhU6YYPw/jaAGEPaH3Jk/W+CFkvttxIGPlkyQb6PIesCswvF3rM8dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZN7dKsHwjHRdjpK27Vrd5XS/TUoCBXTkY+1R6Ij4s7YyaIVWq
	icf2efWLhIhLckaeKEsCA1oT6s4ppkZLKuHuHXIdx5zksAlmPX05633vVUgqO922idd6XLCzM32
	cdsY=
X-Gm-Gg: ASbGncubN7LfewAYZr8B9TuAjJgxkzVM4izZf1BEIAIPR6F5/DMsQxudiGLUGFSw90w
	PHLhZKs/5Uc0HMKiQcGqwXNUrt6hYBtyEh+hUuNsd1EZ7G3arvlb9KUNoRqP0s7vUJCBDdhunq2
	lpyNaY2b3yIrP5dwTJ/jPdn42TmGdIRAc1lyCzajLTXjHiXUgPqBWMHWK2USoWLmBtBsISQFJb1
	OnZWFTdaGf3P4e2xRpCw6jUPnp+xfA+bjQPGBtiRqfpy+GGQJLisGPrw93opjgqokrA8tzWy71O
	PdnTjUH7IrXtr5YtSWi62PtrbaoRzramtGtW2VyXzluUWun41ot6nW7GkryNAjjYrun8+CeNVEs
	D4m4plUhZq+BlZow=
X-Google-Smtp-Source: AGHT+IFbarZZxnuGdEIcNxHTdtx9ncDHcHXXZLfwwDFk0c7S4XwskR5r0Tcfdvp0h6o4S0UIJPdXug==
X-Received: by 2002:a05:6214:5981:b0:6ff:16da:ae22 with SMTP id 6a1803df08f44-70494e94cd8mr5492326d6.17.1752074601088;
        Wed, 09 Jul 2025 08:23:21 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac6dsm92634596d6.96.2025.07.09.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:23:20 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:23:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: core: do not bypass hid_hw_raw_request
Message-ID: <dfaf82da-c389-4758-ac2c-102fc418ed41@rowland.harvard.edu>
References: <20250709-report-size-null-v1-0-194912215cbc@kernel.org>
 <20250709-report-size-null-v1-3-194912215cbc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-report-size-null-v1-3-194912215cbc@kernel.org>

On Wed, Jul 09, 2025 at 04:51:48PM +0200, Benjamin Tissoires wrote:
> hid_hw_raw_request() is actually useful to ensure the provided buffer
> and length are valid. Directly calling in the low level transport driver
> function bypassed those checks and allowed invalid paramto be used.

Don't worry too much about the sanity checks.  If they had been in 
place, we wouldn't have learned about the bugs in __hid_request()!

Alan Stern

