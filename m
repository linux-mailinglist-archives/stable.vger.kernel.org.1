Return-Path: <stable+bounces-32334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88788C883
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D81C64B39
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080313C9DB;
	Tue, 26 Mar 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djz9MgX9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748D13C9B4
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469158; cv=none; b=bCPC2JpyV5VGuO4xz356g2f1AHATKUNTb9S4TrO0q+nTD/lTrA5dcHF4IP/A0CyNK4zLP8/0gk14XDNMyA3SEVZbpiwYZcTqmdR1wTnlDHSfwsVu7O5jlLXYORyjMI4tdG6PcKH6euppx5QPoEuIhEXrcYskYwBoNkSGk24GEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469158; c=relaxed/simple;
	bh=VeXxi6qHZQylZGBHh4BKY5FXS27zFr0AFMXg9sxVX2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNV4fbdChv2Kr3Hl1oYoLcsBawml+s1h+RJ2Mu7hnm4Ll74A65JvrW1KbMRc1vH+ENGn7rk4nHpvzUOXXHRYiaR35qpgSrrCYn/Qaamu9646ArMXte/zN0ES8vevAUz0vAdBnVn7xuyygfqHkoC7PTOWXYfTPaCOovqmIorK18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Djz9MgX9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711469156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0yFV2iWOWXUGcViPgWX13kSZw6Bw/i9IM+nByXHIb4=;
	b=Djz9MgX9qrtp2EdCTbk3zBzInOuD1dsFblPAhM1t6bQlBeVUM/bMTxSn1k38/rHBSmx0Fe
	BNKdo9YLwItI/x6jrT5Hi4VKa34dVzHlRpCEECJ5oUp6kQO1Eo5FOEi/EilMZtdvisKjKo
	ioDvrkHH2/u5W6K5ufZ7wq1yQxtt4xI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-oIgkKUfwNn6PRb1GdqH7fw-1; Tue,
 26 Mar 2024 12:05:49 -0400
X-MC-Unique: oIgkKUfwNn6PRb1GdqH7fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF23D3815EE8;
	Tue, 26 Mar 2024 16:05:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2782022C1E;
	Tue, 26 Mar 2024 16:05:45 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid the interface always configured as random address
Date: Tue, 26 Mar 2024 17:05:37 +0100
Message-ID: <20240326160540.224450-1-jtornosm@redhat.com>
In-Reply-To: <20240326092459.GG403975@kernel.org>
References: <20240326092459.GG403975@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello Simon,

>> In addition, if mac address can not be read from the driver, a random
>> address is configured again, so it is not necessary to call
>> eth_hw_addr_random from here. Indeed, in this situtatuon, when reset was
>> also executed from bind, this was invalidating the check to configure if the
>> assigned mac address for the interface was random or not.
>
> I also agree with your analysis here. However it does seem to be a separate
> problem. And perhaps warrants a separate patch. I am also wondering
> if this is more of a clean-up than a fix: does it cause a bug
> that is observable by users?
You are right, really it is a separate improvement or simplification.
Right now, it is not affecting the users and it is not producing any
problem, just a second random address is generated if there is any problem,
and this is not necessary, because there is a random address generated
previously.
When the extra reset was done during binding operation, as we were modifying
the pregenerated random address, the check in usbnet_probe was useless.
Ok, I will split the patch in two to be considered separately, the first
with the important fix and the second with the commented improvement or
clean-up. 

> nit: AFAIK, if one arm of a conditional has curly-brackets, then all should.
>     So there is no need to drop them here.
I didn't know the related criteria, I will do as you say.

Thank you

Best regards
José Ignacio


