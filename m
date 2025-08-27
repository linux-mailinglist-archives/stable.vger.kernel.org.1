Return-Path: <stable+bounces-176489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F848B37FBD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 12:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F0E1B68701
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A82D6E67;
	Wed, 27 Aug 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaDeY4em"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3753164B4
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289969; cv=none; b=YTogAuoGVpBk7sXwhmbdpNI9yEsejRzQ1vB3FRhXaN9cjgUxtE4OP+87F20WzySyNxDdcCMeXAXi7JzM0OpcDqQMSN88L7e4t7n55Dnw0IlADJcQ7pvtGnOWMqab6HVppqykBuBTY2nnsjUJupdaEvgEqbZzT6QmyqLpawTu9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289969; c=relaxed/simple;
	bh=y7lHJpJz82+fq+cmoA2Rje1ObPa1jJyCFZ+xy5la4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQLDtnAiDWY1RqD5vUiDXWowNaKO+UbBD4ZmDKwWvBv7oExhY26tyeARasf2D7DgxCd4i02spiTxfBa7okze8E9hz30ku18F5Hu61mwVWzG4sO4da/Te3Vf4nXIcmBqTis+nFvHCgioFconpKgwlVbH8YkjyU1h7RaXiuU5FxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaDeY4em; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756289965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnxDSV7VEWbUTH7IQE/IACCp8ml0MfXzZao1fPU++/o=;
	b=MaDeY4emh46TyuDhi9u5VggURvGzCcJVrl0/6yrq77/+auWoes45ALUxEUCDwXYbtcM2si
	Safn54F5lzXGro4ekGixZiyclIbb4WEYOAItPeWLu6Gu6ovErbPrwOlg9hJbFSTibqpc1G
	oemDgfr2lVDksApkSvzG39g1dFL4ZL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-7VnGk6WlMkGJUSniymB7VA-1; Wed, 27 Aug 2025 06:19:19 -0400
X-MC-Unique: 7VnGk6WlMkGJUSniymB7VA-1
X-Mimecast-MFC-AGG-ID: 7VnGk6WlMkGJUSniymB7VA_1756289958
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cca50781ddso395511f8f.2
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 03:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289958; x=1756894758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnxDSV7VEWbUTH7IQE/IACCp8ml0MfXzZao1fPU++/o=;
        b=gmvtq4nQgivQBv8MqhjyG7MQarKuR6TXfX8lS0lYlvyf793iZG0Qa/Dg3LjFl00nrZ
         EkLsaWOQXHSpKfPj0rfSpKgHPcDBiPrA532x5jxJ+VDDGVN6vD0UnTMvM7T8B45vIdSA
         eoQoNMkHwAfbKk7pV7zKULOWg16/pnwmnYG3eBPsqIiuLzkcqCOtI8KSCbEhQBU7+5nm
         mi0hMTCUgQoYazPsJ+f+Zfo7ckdYHqQ3l+QrStW/4e0cOg72VKYTWOBYqT7tmE68cCkh
         YJ8pIOxeuV41Bhg8hqxVLnMi41Wj2a0qt+689bfQjjNSpjB6C3jU//d6CRFpWw2FQ79O
         Tsrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqyWS0TOEz7TB8SxwJJbe+pmYouqUj0LDiMRlLMrkK/vG/yqm8aUiwx4qvSXEEt7blJU1Ge4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNHia/JN3+gFHpaq84LThu3O++b2SVw9RS7zqR9ECMrWjoVj9
	B+YYjkUpRIASKoElnlmIwNH7tjIJ+SrZ523fzhQwJguvphoW0Or3NO6LhuA0PoGEBjXjgan47Do
	1jeGEjUQq0P/7k6eg0RE/jkGskGZ5OYQbXFZwKPjB0nihPQb/lRGB8fjdJQ==
X-Gm-Gg: ASbGncu0VNlknmW6bhYqKeHa6acN21xG1i5p+GXVvBgmACTSyCnpsmr8Lh8lygVO6a1
	jrUAXkXT7PSOVXzGyRklnNvWdQl0VjZjZVb/JB7IqjEjrFUkLVJCOsSQ2vMgytMaV6hrisJ2wDw
	NI+LAzp1Twxl4cT3QDvma/+HHbN4IZPUD7Oei5z2gyp/StUkhiHWxMEA/Wx4vN2E2LlwKqxT0nF
	oqCDxJA8FeJberRVALRfdi8OLc4wRNankAUJ3vt9oTb8JtbRyIsZvOQmVM74aCbY97+/mHwEoyl
	4NeVof4mZM4IkRM403O2MFqVwdrNO/0=
X-Received: by 2002:a05:6000:3105:b0:3c9:c3dd:76b7 with SMTP id ffacd0b85a97d-3c9c3dd798dmr7365857f8f.13.1756289957758;
        Wed, 27 Aug 2025 03:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnBgHJDVrf3uqIPu7fLXfZWC1O9D9UZiySAsYPd5ClZgciVjBuom+qiFTUkCyFtJ3+vfLYKA==
X-Received: by 2002:a05:6000:3105:b0:3c9:c3dd:76b7 with SMTP id ffacd0b85a97d-3c9c3dd798dmr7365831f8f.13.1756289957299;
        Wed, 27 Aug 2025 03:19:17 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm20132997f8f.56.2025.08.27.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:19:16 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:19:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250827061537-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> > What I do not understand, is what good does the revert do. Sorry.
> > 
> Let me explain.
> It prevents the issue of vblk requests being stuck due to broken VQ.
> It prevents the vnet driver start_xmit() to be not stuck on skb completions.

This is the part I don't get.  In what scenario, before 43bb40c5b9265
start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?

Once the device is gone, it is not using any buffers at all.


-- 
MST


