Return-Path: <stable+bounces-124776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F2A6714A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5516E422108
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924EB2080DB;
	Tue, 18 Mar 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpuI138O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7820767B
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293763; cv=none; b=JMboFRfOzFHku+v5xpdaVkkf1Q5gRZfQsIZ+FVZyGdJT3lai3v8zI3CwaeGznoPsDSZJrqqY0ZtFyPBrtfgMvlsNQwce7R4s+pmzOJFOAypXXIRmBxAVXQscD1CsxgOEsoUdRiRaB4B/l7Gga7D6wC8CAGZeZYqC2XY5Ls9TmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293763; c=relaxed/simple;
	bh=icRL3FzX7n5CwQlt+hD3T1io+oS0x9c6Jm2EpRDFMI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioAMMFY6hYiM52SKDkBrMyu0uji3eNbN6IqJAdvgxNKtzY+Zoi6iYtpNSemnzKyABGlu/NajdMWNUxREH+LCV6N7/+1Tfh8xC7O4Tv29KzKsrmzrXp3FqATgFmW9wpogH5y8Jon1qoG6nJXhgHmOlxgYPzgrBCjPZbkUWm4lTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpuI138O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742293760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RqQ9ZAEqwS3Wc2GhSiEZkrs2uvAiEdXS3wPJ9ZEBc=;
	b=dpuI138O+wuQ0/6NBDI134S7odDCBR1jddYoBdsuiTMt/UMhiR98ag+INXQwpH8c2GSE6v
	M07kuVG7WXvNFVyErXzPJ/4m48wGBdS4FkFpxOJUgYH1MeUQsyJczCzfgUQHF60ymp+dwM
	cNwlY4aMbYvsK2nv8O2AFGZyyvmKzn8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-6shFoH27OeemSPHa2eekvA-1; Tue, 18 Mar 2025 06:29:18 -0400
X-MC-Unique: 6shFoH27OeemSPHa2eekvA-1
X-Mimecast-MFC-AGG-ID: 6shFoH27OeemSPHa2eekvA_1742293758
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3a9c3a8f7so1888866b.1
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293757; x=1742898557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+RqQ9ZAEqwS3Wc2GhSiEZkrs2uvAiEdXS3wPJ9ZEBc=;
        b=soyv/NrGcdO2ExtHAcup48+tgcrKvGx8XoixXCMB89tR1IrzKzy0D+Ybe+owjDVCh9
         W1ZKvdpq479ODZERkVcjgWAIynaWBKG+DbZGSO3HD7QAI/+ftmERtT6X4VlJSSEkQ9YP
         KZL5ersDJIdKgHMCkS73MYY9/ICcEKOFsnXH8kWEKxh0NdLwIRL1RETWNucLjMyQIaKn
         cR/S8RBi9KPTU+cIMNLwyot1Aroh6PaJzs3DxAuQj8QadVAxcZBNeQ53akSvIIIKfUMz
         CjaFi10CovXZPw2zepkGlNKSj1LYcLwj7SLXcnFVrnANiZ/L01vIEhJ1Xl7j0nzl9359
         o+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUb6C7MI2XxQjz3eXFhWwkk938L3LMMZdie5dqNmSC4LWCpKQLaMigTESlD8bDJGQHGHGRIRIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIMg4p6lx0sgtA87LpJoNBTCX8r8DBanP26kOEzwHAIu6/gbr
	FrK9E1jQvf0Od8EGsaniS7yyn2MfVxoNAR53a5z6omfNLlBxoU0RxdpRkTfRIyT3OSBnASTAPVj
	4R997SjYndJnowMkxojgyoFlBvXWbotl1ZqCq0Aqiw0BQy9enKzt3OQ==
X-Gm-Gg: ASbGncuQzS8BwivUpKivwSkEDSTaKZhYWhW4gic2bCGs3evfQagGOvdYkbEPtqb1jL1
	/vqGxXa7DmWuvuyR2PKSRcV1lOv4lreKRf8mSQlwaAVig6j9X9iRnaZLX1tVt50wG9BaLRs2N1v
	5Fj60CYcn3OY6gkeFkymN/OrnvQ3bskhmOX1hp37inkMMGulEiHrqzQGFVAJfar6U/Mw0353x5h
	8Tp+fVph/1tTeIWqf5NGg9/bMTBDU+4DlnnKJUMeTdFQeVNOz/idber//UhlSfs+KHTnme9b6a1
	+I0UUNY9KS3mqLNe+CkZwV06RsI9teY/RUPX1atom8UHXg==
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id a640c23a62f3a-ac38d405ac4mr326112666b.17.1742293757538;
        Tue, 18 Mar 2025 03:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9phnirtnPj5YmMubP6Ht2qkaUfOSLn82FDbJFuRSYXcPah8hVaAareCATLF7C7En8FYvbA==
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id a640c23a62f3a-ac38d405ac4mr326110166b.17.1742293757124;
        Tue, 18 Mar 2025 03:29:17 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm831316866b.66.2025.03.18.03.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:29:16 -0700 (PDT)
Message-ID: <491430dd-71ad-4472-b3e1-0531da6d4ecc@redhat.com>
Date: Tue, 18 Mar 2025 11:29:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart() and
 cleanup error handling
To: Qasim Ijaz <qasdev00@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org,
 syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
 stable@vger.kernel.org
References: <20250311161157.49065-1-qasdev00@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311161157.49065-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 5:11 PM, Qasim Ijaz wrote:
> In mii_nway_restart() during the line:
> 
>         bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> 
> The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> 
> ch9200_mdio_read() utilises a local buffer, which is initialised
> with control_read():
> 
>         unsigned char buff[2];
> 
> However buff is conditionally initialised inside control_read():
> 
>         if (err == size) {
>                 memcpy(data, buf, size);
>         }
> 
> If the condition of "err == size" is not met, then buff remains
> uninitialised. Once this happens the uninitialised buff is accessed
> and returned during ch9200_mdio_read():
> 
>         return (buff[0] | buff[1] << 8);
> 
> The problem stems from the fact that ch9200_mdio_read() ignores the
> return value of control_read(), leading to uinit-access of buff.
> 
> To fix this we should check the return value of control_read()
> and return early on error.
> 
> Furthermore the get_mac_address() function has a similar problem where
> it does not directly check the return value of each control_read(),
> instead it sums up the return values and checks them all at the end
> which means if any call to control_read() fails the function just 
> continues on.
> 
> Handle this by validating the return value of each call and fail fast
> and early instead of continuing.
> 
> Lastly ch9200_bind() ignores the return values of multiple 
> control_write() calls.
> 
> Validate each control_write() call to ensure it succeeds before
> continuing with the next call.
> 
> Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Please split the patch in a small series, as suggested by Simon.

Please additionally include the target tree name ('net', in this case)
in the subj prefix.

Thanks,

Paolo


