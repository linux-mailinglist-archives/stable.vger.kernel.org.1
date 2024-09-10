Return-Path: <stable+bounces-75658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022969739FD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFDB1F21C83
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3F193096;
	Tue, 10 Sep 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe8JuEWq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A019309C;
	Tue, 10 Sep 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978923; cv=none; b=b9Pl8EUVLl6lSWDZAAXYqx5x5n48BzlY52WOfspJANywlZRWFnPXWc+eGCNV4siBbqNOWhkiWxmD80p6Ui2Fd/gMx+Mn0t+d4Zs9ksTNH3atjqufNrtlj7duLvrAkDWlolbLvcjxM0ra3iy1DCFIVaFG10FxPBLDvPb0pMc5EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978923; c=relaxed/simple;
	bh=cnBKc6QSEPPGpTooPRBqwMZQ7q3hlFQG/diuM76jvik=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=msYS3nhpvuqnOx1kJLCaFMabg2y1oBSeN/41FRG7+SKJag+GA3yQUw8O878LoG9MGARbRuy7Vr3RbyF7bFV/QdtaFDaGJ2MENMpRz3ZpktCVFcG6fcTWjRjvCa8Btf4cZAZt/Z58yW8lwbJ8k7sPz+H/EVUYc01fWJW/XxsLDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe8JuEWq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99e8ad977so336984085a.3;
        Tue, 10 Sep 2024 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725978920; x=1726583720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQrftbtO0vVoQQg7Rm8RoTAZZxy51Jatmrm5N+2ea1c=;
        b=Oe8JuEWqXl2hG8aJkXCGskvlybXicclkOkDooEOU3+/yARP1ENafu3kK6NgHt6p8le
         y5re3jRluI0XCOGJsXe0813KS+a6Y6nuraT3gf9MUiAHPn1d0HaxUXlEbtw1CocH8YmZ
         TnItXmCclyQncDwQCMnDrvFByPb8NqShYeXW+/Ph6AHWBBzYDTnzEHFf7WCTAt8xdKcU
         ajb0Y6143YKR3QWsYRp0mm4a2PylEtlIwoJY2P/oAEioT/9CxeDDpDuIQiYhQqlE0jyq
         CCuf6OFzyvxgXhj6o3To1hBiajMZOuHn9B78cjpCrdiI3VBJn2Z3xrsGdthpEWfzvUcs
         SIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978920; x=1726583720;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQrftbtO0vVoQQg7Rm8RoTAZZxy51Jatmrm5N+2ea1c=;
        b=Z3/XeOeBzRw9uHtca2ShSEvkiYnXid6iSy+dkBX3XLXWFo+PIHrD14+LABy0dotfV4
         /iQIuh1+Y8T8mNL/4KRtwT7BAzCeaLHVywtIpU9QVnOLG7bmn+LhviAL/8GqywfZmHYL
         QDmiSiYrRAICMVcAu85FmOm6lW/7yqvoLE+Xew2N67IYgqGRHzsyKiBVbiEkuDY8xbzO
         e6fFReXEG7Gzo82aQ15pWvIM2H63X46huT9O0AjvVbv+GY5my+hR4M3kFjCJbiW03tqf
         qAT47xlaC3UUFlySB9UmcY2RNtkcXxSV1f2vZ8uH9tB9YJkuXYJ2wMhGJO+HUGBBl2uu
         Bz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+KVwpNldyI4BYzGiVeKYVhEhEX/mU21cMn7jQvAIXGIAHTNGUKRiPAECiyYY34XuQj0U2sq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKICojPgNZu78xTfKgSOLDfQJHDhjqSeE7CqNmbpmeJLtJY2XY
	1vSUxUoOolPTACrmvXmQ2W8anPuMBZGYV5Wd0hZv/mfkr0VfbBeT
X-Google-Smtp-Source: AGHT+IFMq1nOfj6B9b980/HhnIOYyLnpjL4IBtxigTBnCmfMqCS6R18QOkk52Jz2SDNpKA8RgcNxFw==
X-Received: by 2002:a05:620a:240b:b0:7a7:fa7a:75f7 with SMTP id af79cd13be357-7a9a38ec003mr1624259685a.51.1725978920321;
        Tue, 10 Sep 2024 07:35:20 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7991f7fsm311003485a.62.2024.09.10.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:35:19 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:35:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 nsz@port70.net, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 yury.khrustalev@arm.com, 
 broonie@kernel.org, 
 sudeep.holla@arm.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.net
Message-ID: <66e059275c121_9de0029430@willemb.c.googlers.com.notmuch>
In-Reply-To: <2024091024-gratitude-challenge-c4c3@gregkh>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <2024091024-gratitude-challenge-c4c3@gregkh>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Mon, Sep 09, 2024 at 08:38:52PM -0400, Willem de Bruijn wrote:
> > Cc: <stable@vger.kernel.net>
> 
> This is not a correct email address :(
> 

Sorry. I'll resend with that fixed.



