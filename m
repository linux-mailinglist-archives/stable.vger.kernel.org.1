Return-Path: <stable+bounces-109392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E16A152A2
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829001696C9
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FC146013;
	Fri, 17 Jan 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW5+GmD2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE52B9B9
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127095; cv=none; b=uk0yrOG8N+aYwtz+P2i5lI18N3y6sp703bUeLEQH4XlGq2nAXae5dUMhDmwnhp58JlMomaI1fBBUO71J6sY4zLn6MG6F//niMf3Ip1xnpUPi0OGdzeUB5e6CSsZvFJegTU1iGmTyvX51d8keqTA9T9A02RjDZaOO9NhJKDTw/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127095; c=relaxed/simple;
	bh=r5gfrwCYhXiBFd8QfgNOM0dbwFRlbMdfevSFagig3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulEmVzZE0b7aqEPIbWObp1g6V3zbVy7J1WB/C65TjopmUfedgjxQ5FF6FTkafJ3TySR8BrJugEa0M/MJ+k/0CgGsn91mk8DGAX0/Imo1ZxP86T/hapwcCzau7BC/f9UmtTDNSR2gRCW38FLojoPIcbUC2/PGgKm38aXiP5iMyB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bW5+GmD2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso3312069276.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737127092; x=1737731892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5gfrwCYhXiBFd8QfgNOM0dbwFRlbMdfevSFagig3R8=;
        b=bW5+GmD2yGYxZSQHEjDqW9yASzYq9mtMRkds8kgP3sXsTYGoBJkM1YsNN9f2P4PhMZ
         mQBu+KC7BlL/FSINsG9Ib0FOiYG96tYz7px1hmGjpBdStRbIVI9ItXmvTSLirFnPKAjj
         rqIJp3KCt0h9hzUW96FStbAocHQjaIe7cxqy0DXbW2/65C9EglcLUCrgUV+UfXX7fBjm
         lWdlRy49LNrdH+ovXfK8sAKirOGTUmBjSe4u5FC5FcZn7mYP8t9ngfLmB0O+vjGeVNcs
         HsieHxr/T+tU99ePBf2WLG/pXuPdPiB5NZlk4bYTt3cfLIL7WXmKDk+jO+kLudFAW8si
         nyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127092; x=1737731892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5gfrwCYhXiBFd8QfgNOM0dbwFRlbMdfevSFagig3R8=;
        b=Ylmdl0FVdf3F8Z4sdh4I2OW1cpFON8GL+ngJkbg2bWbdg+NLuys9lMYDQ6LwayvgYO
         Jk5WHAodYa1oZh4njuWtnBxjwheumjnnvWArGkw0H9CIQfeV6VRmqReuN9SA7siddEyn
         dXWjaSvyCvyF8cscdCfX1VfP0CX8jaOaMRfqNteSmHjPocf/PZdu9XpVRrh1NlOfsdPv
         QhngPV+o+cot+FVh3c4YFP7WIFEwjOJu7SS4sKGNKc2gKVaQhfaI1/jER/2dhuUIgAJK
         C1P3kSj0IAkmVlikSh5sCjZrRYp6qKxGVnpilDqSBiBVFZihBU8j4GE1t4bV7wxbZFPs
         qaEw==
X-Gm-Message-State: AOJu0YwHkVjVJ8Di4gTgWWYXc46aCfC7w7T3ZiQbUH/R6wSEotnkFUQk
	2n50SKwWYB7whl4tAMbCevvvFmIQsm9DGB/X6WTB6t53KedmpjvMugnoSQNPItBSZpMCEaKYPhj
	s+5SWQHluhwhyTyj0ioN+L9DRCFB8Bz5xCw9M4w==
X-Gm-Gg: ASbGncsXvLTtTo7jwxyWhApm3u3cXhs7UAtkkdiuWEDhaBqt55wYBymlzqsrKiHPCBN
	OlEhIYmdJknSYXHZT30WqAcebgS6iWEdfzYTa
X-Google-Smtp-Source: AGHT+IHdNqUGwDTrcGRxRTDN/0cqnZ+8Xq+27pa0/unVlrUTi1ZhKMjre5Pa7//xtPewNlU0bJD4WBwYLd+IDxBfvZ8=
X-Received: by 2002:a05:690c:f81:b0:6ee:7797:672 with SMTP id
 00721157ae682-6f6eb6589f1mr19581867b3.7.1737127092603; Fri, 17 Jan 2025
 07:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
 <2025011740-driller-rendering-e85d@gregkh> <CABeuJB3xEQfgx1TiKyxREQjTJ6jh=xt=N7bTQoKgjAN1Xoa5WA@mail.gmail.com>
 <2025011710-chug-hefty-2fd6@gregkh>
In-Reply-To: <2025011710-chug-hefty-2fd6@gregkh>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Fri, 17 Jan 2025 15:18:01 +0000
X-Gm-Features: AbW1kvZRlwwM1aGoGDk-CVgxo9-cGW6MjQU52XVZC64COHp7ZMWQCmf7SExYt70
Message-ID: <CABeuJB0jMbysm06guUvCA_O9Dbqmd6n0X93deiVtqgQwWW9TQA@mail.gmail.com>
Subject: Re: [REGRESSION] Cuttlefish boot issue on lts branches
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> One for each branch please, as the git ids for the commit is different
> on each one, right?

Thanks that's what I assumed but wasn't sure if there was some script
that did some magic.

Sent those to stable now, let me know if there are any issues.

Thanks
Terry

