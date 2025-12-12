Return-Path: <stable+bounces-200883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C6CB8510
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91BD30361C7
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E82D592D;
	Fri, 12 Dec 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHYuCuh1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC062868B2
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529213; cv=none; b=Gvpn385HpIxZN+jl+bfCO4HIqAT7srhXR9Xl3slEI/qxHslLhZg+bNsVoRP5pQsGeEE/GT1q+P3pOBZ2IotS3UOe7dipwfQpFhpyF2vhT+/d62DrvVvm3rx7Gn8/vGMbo7DiR9mFPKyKB5AhCRmSwgnv4DD/ArV3YqeJbGjcIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529213; c=relaxed/simple;
	bh=UUz9FBZ0VjTdrrNvYZ/9wuunSrYYvwDzroYxL8D0MTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxkD3b9KJ+/YAe6wUEecn5bqiwH1451FBypJDOGgTdoyU7BOEeL1/oDbHYC4JWGrCI8wzSWGvCT1XyM/RnYefMjQl6GfHKuqNw0tqnkwFId7KoodHSue9Da2ju/M48oPncF87+EhYUTSRzIjShMUfvL59nSQ9XCehuGbR5yw5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHYuCuh1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so930468a12.2
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 00:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529211; x=1766134011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOyh7YwZ/fjOnqsi8in+FWH0IHyn2UOzmxthtzGPDGI=;
        b=JHYuCuh1zc4VZaWVD1HHlKVfYLMThJVsoZ5IDRaXRYmRzFhgT7o1OxwJ9Vx2Ul3Wdy
         IM8Q/jz1TTBYhWUJaZfw6FbOvaVJEOMhWDVPoOjAG+GAVlnzWsLXij7kP2Stsx8/e9JH
         q5wUscZRXRf4vFi2bFUOTG3T5syvset9Qdc273XGefIuTo/By6HZ6PuZpJQOp/FrSFzP
         Sbxf9Wn0hcKoZFoIjntNwd/7O4Xi1Pt77ACu9OIVoZ08RYQgWQSLTvgeFkX+AhoWXV75
         DYL8fr1svP1l3dXUCXIukKSW1LQnnymyPpPWYZZLGfXkoaK+pi340Kb6/OMEtosV35ll
         Gpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529211; x=1766134011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOyh7YwZ/fjOnqsi8in+FWH0IHyn2UOzmxthtzGPDGI=;
        b=OJBlIU+wcJaO/ko9HhJwRjJXakdBR1poqV+zz97UxGRr4vmYb+JbeXXVXl8ufBojuH
         hJZxreP7drw6ZhvulmnMLRnluaAv2cCt5azlhBilXtgN0EUMLHncLj1lUSUb4Dtm5QLM
         8tJxtvJX9zB81u+cLbj7eFOTifRV9C/hATHgDtPXgKXnqbH475AIYvlJTArmIj/2ueZS
         ofsCgZixnMBa3/LOABxmuViHNSid8GYLEB+RekDovXARLMp13BY30bgjwbf3GBfee+Ad
         deha/UKzPRgt3HZdrKJPHpQGVxn5aZMSvCQL6d+aXE8Cg0/Q3pcRaX602GoLzdbHrV0s
         BfDA==
X-Forwarded-Encrypted: i=1; AJvYcCWqH3i6eE5jfqop32bAu4ddCGJq0Mjm31PclJqbut9uuWM+hoo9DxfsHA7KvgmgSMgp+b2XXNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxyXTl9W/zioaznZXJ+gzK9mAdWwBEg2QmumfG0ZWX3Z6JnL6
	gwbT1mAtQQn7Qrv8DzsfgUTptyRW2oyuu0EaqQBhDJHX8isSEzF/d0a+
X-Gm-Gg: AY/fxX7+CHJWgpH7DBZV+K0yaGWtpc/kOkhZCwuylLN9h0vOpzv+JM1DVoWZaZNCO/R
	MUELUxYtk1G+ArRQ40xgy1MIJTpcbUO9jZqo8pfns+cmeSfuPJxEtja7QVGvWIXaP+7suGoYjSq
	1CKmsslLyqBT1jaAOLGo9u3p2XhlAi+SCekiMn70nC9mkgz5G9wBNIZBBzDnBCcF7kM0iMiZ5Ex
	BUONO+LogXndQN0iSlDC9gEyT5xsJItScROLeXPL+eWN3cPr5888rLdmVOdLkc214jGpn3eMYnR
	p184IL8mYZCVgpaMqRsKsGca8c8z6Pjuap3xdjsgusUhLPPA2K2Ku8PVmkSzL9r1DYXgX36jFuc
	zjex06Azh1OkFMaESJUw9L+tezdPRfkVEVCAvxeKWReSjxbJGaMEYBqozalXjVjozltAFwxstgS
	l5eGMoPnod1hsb3YCuJ4QA8ch5bFrlTahH2L3S7AJuiF6aLFzqmMw=
X-Google-Smtp-Source: AGHT+IFxRnn2Hnk3Fy94esqvbow5sOCCjS7YFOHFngABs5YEgFMaD0CbN/JFTsoo+Ygy71nEbS4+iA==
X-Received: by 2002:a05:7300:d10f:b0:2ac:1bb1:68ed with SMTP id 5a478bee46e88-2ac2f85e863mr1040229eec.9.1765529211350;
        Fri, 12 Dec 2025 00:46:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:fafd:f9bf:2a4:2a0b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30b799sm14228199c88.17.2025.12.12.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:46:50 -0800 (PST)
Date: Fri, 12 Dec 2025 00:46:48 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] input: lkkbd: disable pending work before freeing
 device
Message-ID: <tquiwnxvffkbxw6o4x66w53cujhkitzlleemwzoidgtjhxwwsr@ojotqpywkfwc>
References: <20251211031131.27141-1-ii4gsp@gmail.com>
 <20251212052314.16139-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212052314.16139-1-ii4gsp@gmail.com>

On Fri, Dec 12, 2025 at 02:23:14PM +0900, Minseong Kim wrote:
> lkkbd_interrupt() schedules lk->tq via schedule_work(), and the work
> handler lkkbd_reinit() dereferences the lkkbd structure and its
> serio/input_dev fields.
> 
> lkkbd_disconnect() and error paths in lkkbd_connect() free the lkkbd
> structure without preventing the reinit work from being queued again
> until serio_close() returns. This can allow the work handler to run
> after the structure has been freed, leading to a potential use-after-free.
> 
> Use disable_work_sync() instead of cancel_work_sync() to ensure the
> reinit work cannot be re-queued, and call it both in lkkbd_disconnect()
> and in lkkbd_connect() error paths after serio_open().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>

Applied, thank you.

-- 
Dmitry

