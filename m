Return-Path: <stable+bounces-169441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573DDB250BA
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9730179E93
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2A28B7DF;
	Wed, 13 Aug 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ApKwlqYT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6E289809
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104339; cv=none; b=oJb4A8KHN96NQyWxCsCEqMgpOWnbF6crW5m+6pzbvtYJ7TxlTKnRB17BIGEqdYt4DltK3KQx1CoiNsuOE7mgqm/p4JfR6FMTY3oq/HvI4JDiGh2NQniTXSmWtJLPeQBWXodN2G+dW+a4gnrc8Py/YSwzG1/+lryIXayNxZQ61+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104339; c=relaxed/simple;
	bh=WltyD/Gu17z0VQIoy5UrL9din5O3T3+b4q0ZfweaWlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0cz90ZxscVaH+kaEajuRtqIKWz0bTxYSOKh06+C39s6wKbh31WLJKKZs0NkvdZrnFvV00HdB3mdYy6gzvTwqmZW7acxGvaH1IhS0TRSOQUNIoc7TQi0KnDgXJzoRNemID53gcCug2PNF18sq6ZoJZEI1apgAoJ6V9G5QwXUl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ApKwlqYT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c482c8so1449771cf.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755104337; x=1755709137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixsrcuhdRVNDNuQRG1GynUI+Z0v3MMN1ZtGtSSllJ7g=;
        b=ApKwlqYTo62Nzv+8dil01LP7/QaXvneAjppO0ThGu17eQBVAWuz/mI0v8MrWzjvO2M
         YFlD81FQCgzVADvCHkI9Gp175K25HOi61Lr60zS3tFUnraEfLBle03B0vQCGImT8nN9H
         UT+zpVWWhbbtbh/BaFFaEVMTPfggmfyx+CQ4KElvcjZSM0TfcZ2G0JpqHKCzRpBr+2A+
         VSOGBaWsJQUp71h47zOCNnynJvfEO778mkNKUMw4+qNDJdzZGfNZhZVddd17u824vPtV
         w/Y5rUesDFsSRlIYicMoSU2BfoonJL1zn3ndEG0L4nOfvpWTVkKhMNETyqhfqnH6BYGg
         j09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104337; x=1755709137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixsrcuhdRVNDNuQRG1GynUI+Z0v3MMN1ZtGtSSllJ7g=;
        b=t70vFVOFLyOysd5hPvR/rCM6f32bhID8kLmzSM0iMI6E/ShbMZdvpHJGBOvn9HsZlQ
         EIHqOUCdb8W6SDuY9aaIuxmqoujz3MrWV460KAuU2i4sN17j1hXhyNXNyJOR4ZjwNULi
         z86kQmdrvCOr7IZE7MGkI0Eht/6/dVvXogZ3F9Qdn8iT5aeRY4BeW7UtRuaHF3YC20Zc
         fosI31f9WMJAF8w+lVBeA3J7FFV5DWIN2su+0mzJKkc17Z1VZsaJuZNdb9n7hvmbRs6A
         q6clHMKrtIaijaZSxZUXgzDTvKFboWomL8bYaUEMgHcYeTuv8L/WDoFAHyE7LHmY7DO2
         y+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBOd4rBHdgOa3b5W3QhXQDd7VMBH15CIgPR/ewyD661tAciEm/QmLCMrdDwf/2buj7sT9YqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywle8tfMgJPH5PSPmzq4FtqgQnpWhUhML9dklRiAzXbHEf7ZHY+
	G2QkEUjXgMOm6F9yZqT7yd8A9AVUas5ifTtlLgryvqQ9ad/O/PvdZ8zagnnUKvnGHQ==
X-Gm-Gg: ASbGncthPUegXzwhestUCF4Q7jtDffvS/IFz7e2ncSyhP+cghpUSq/cPb0AXqteAQUf
	aCifl1IUYxkU8e7/tw4Pp43rhIC7+3pMPtDUbDSVBHPGsJ+jblBq3SkFYIvSI0G1U240f2ofoZy
	BIAeVfaLvtqp8ACkBgorhMRPCGbHa1/x8qb7ytlLgEj0RP/klK84a8vSytlI1mphAQVCcPNUjOL
	KY18CBpyeZo015D+xsrOPEY/9AFKCYD422+GK4naM4VLQokuUg6FQNHN55lNRtHrSY0Hf5kFSGE
	Rr+DzGS0rgmTIxO6Ztgb52GEuMYNaWLEg30pLs2I64uWnHulTxzva+zP2Z+G7i62zBAvyXeJHsq
	hq+LDQUGLFpnBStpwNMTn5yUNBf9PeCmGnD4WV3iZhP+EqWUVrSNBJTHJwmHFG69QqQ==
X-Google-Smtp-Source: AGHT+IEX6taY4LlSwkNa+zM7dfmEU6izv8eUHX/5Yu4/4FOwk0gfPE982AWmeEaP1BJ/slfTY0ES4w==
X-Received: by 2002:ac8:590e:0:b0:4b0:89c2:68d9 with SMTP id d75a77b69052e-4b105f7a7b0mr16894621cf.36.1755104337064;
        Wed, 13 Aug 2025 09:58:57 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b069ca56d6sm142258981cf.36.2025.08.13.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:58:56 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:58:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zenm Chen <zenmchen@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	pkshih@realtek.com, rtl8821cerfe2@gmail.com, usbwifi2024@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek
 multi-mode Wi-Fi dongles
Message-ID: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
References: <20250813162415.2630-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813162415.2630-1-zenmchen@gmail.com>

On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> Many Realtek USB Wi-Fi dongles released in recent years have two modes: 
> one is driver CD mode which has Windows driver onboard, another one is
> Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.

There are several other entries like this already in the unusual_devs.h 
file.  But I wonder if we really still need them.  Shouldn't the 
usb_modeswitch program be smart enough by now to know how to handle 
these things?

In theory, someone might want to access the Windows driver on the 
emulated CD.  With this quirk, they wouldn't be able to.

Alan Stern

