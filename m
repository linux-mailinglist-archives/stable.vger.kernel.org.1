Return-Path: <stable+bounces-136690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96491A9C4FC
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1E4615BB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C5243364;
	Fri, 25 Apr 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPo8XGzK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE323FC49;
	Fri, 25 Apr 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576003; cv=none; b=dGecezmpSFMSdnnG/m875AYm2AwthmDXx94YqAyOFuTcvqxIGMo+F/QJIi0wcCuTPMu0aLYVLoxlPwnUM9F3sB+B9xk65uxDGOIfuSFnbe26lrIDzFd0eAvKCRxgUT646QxrYNGZRdWmCG9CFeF/XKFwOQiW1FLGh+w53WCO6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576003; c=relaxed/simple;
	bh=leQ7yhAu9noiNiGYZltHvb58booqg1uL4Zo2ckgH484=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R92U2WK/hHeBJpn8PbbTUHNEgh6xJl9EEYRuxzCKW7FZDUVPwjbOe8M0lezZwIvvOzbQ+pTfuPKhtVKcHdJeFnHXB/0uNCLH9LcN6u3cpmNfz+he3YgykiJKjGqsUbWyGVtajb5VPgqIvM2bymTA2z2YG0/MhS5q8cZyLOYg/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPo8XGzK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so13569095e9.1;
        Fri, 25 Apr 2025 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745576000; x=1746180800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leQ7yhAu9noiNiGYZltHvb58booqg1uL4Zo2ckgH484=;
        b=jPo8XGzKOhDrNgkbDp8amVvcCzMj0/4D5TtImkK3PJLzI4GsODp28rEp/DkA6khCXT
         JRiIs2n5UtJYrkIq0R9IHa6y6y9DhGEg/nnCotYSHaV+HQgfhDHG5rkfMw/x9ACivF1/
         guPubQQAwmgojz77Seq+5vIx1GanPECppjFq7KS2d+a1AdNXVsGTo7vzz27jbaMK14Rz
         nfwk8c/hc3NRKz09lMB5rlgwIn5j4Tsck8dzNToX41WNB4rdxa0hZ7ms7bNAIUwNdJkB
         syhtF6byBwZaadvk43IEQ3rFdjYyi40EwIY5cJ3RKA9CKUYa3b5aHeLGqB3USOmVk0zI
         lPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745576000; x=1746180800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leQ7yhAu9noiNiGYZltHvb58booqg1uL4Zo2ckgH484=;
        b=MwH2xlT9yxBt2/aoOjwGTytfMQ/k1Nfd3VTyokypdO9ABAQsss+BucAjth+pyrV2wC
         BcYNEP7MVfgiE0ldKoMbq3PUqPmUhgvmGiLlqBpke6nFMw/aPgMEAYZ+EBTVhGQwLWFj
         rfc0TzeVBGF+dUOi+SWWJ9qvSNGLVFYPlnuKduV9wab6cbGS5AhnJMG8stYx6u0UuCCV
         Po9RJlT1Jm4LDaz3cMef5ZFmbibLWKWQpyN1ql0IzG30gTOsOIviyf9aqnmPgf6Vv8cq
         dlRtrTKbmiZ0s4NjrCyUZsgQ3tQmTo28dXbmNgBbMG6JyFxcJa4sCXHmJAZdYr+ZKSKF
         oXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7+uhKbGli4jyVT0Hj18q3lIovVYZ/EmIefqEmGhQ9UKfkZb3Dx+K5k7sckJ7OUHP3IneWtbjgWxaQ7e8=@vger.kernel.org, AJvYcCW7HONWCKSvR+XDKWFR7e0TaM5XAyFViLXNVHuco78W6cm1g4tN3TC/7prWAsfppGXZRKARfFiJiKfc@vger.kernel.org, AJvYcCWgJB05Jal3xB2aFi++bHbk4UVdpSsOko8XHrY/XG4KPPHzajEwfcVcG2Q7V2PCsTXJkZ96tvEt@vger.kernel.org, AJvYcCXiQgWsHbLapbOe3xowG1QFNo8J9dcq0NTEa1vmes/n56N1TEyyoA3fCeXEVRtu2hLstJUK6k8M@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNuU2OZKApQj0bnPBbeXqUJF2cgd2GJg5ohfWOHafckbXBdNu
	hSfz5nsn0VrALpHP9zkFyMXQkEgmiryj9yQNdxjoDUF5cK9VAGol
X-Gm-Gg: ASbGnctmRLMtGEWtbJnazBXpfModndRYhtNJdnh0dCAGj/JtefPqsPjWeM/WiMVZWNK
	Dk6Ask5fOMVHx7ivWSonT636H81WVJR2i8Jv6q+qCH1HtgR71HounyKS7Ug1DMAqSu504HxeCL4
	7bVngwORndVDUOgbA49HNivGrAuLYFGg8GyKSVNmUjx4q8DmlobKeRP8og7i+hx4zrEL5gPvkYp
	oIhGRPbkdnMfXHd4WVqz8CPptc5Gces3v8SURDYcUEv3qxBscxkolt5fschMqEMam24tu4sJhik
	clnuCbI9xZNhf+eyceevJZrKvTvxwD4UaD2/Lzk=
X-Google-Smtp-Source: AGHT+IETfuGeLDMAZxnrCqaBW3NFu5fzExXuY2mpnZTRfDsZm6SbJttDkP7GFTyNTPBz8Vw8yxZkrw==
X-Received: by 2002:a05:600c:1c1e:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-440a6693ad8mr13041395e9.11.1745575999354;
        Fri, 25 Apr 2025 03:13:19 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:ae46:ea89:950b:a804])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53044besm19768875e9.14.2025.04.25.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 03:13:19 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:13:12 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aAtgOLMnsmuukU42@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
 <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>

Hi Andrew, Jakub

Just pinging on my last message. Any thoughts on how to proceed with this patch series, I left my thoughts in the previous message.

Thanks,
Qasim

