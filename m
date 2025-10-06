Return-Path: <stable+bounces-183426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9EBBDB0A
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 12:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 388374E8D89
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978E231858;
	Mon,  6 Oct 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL1Aj7VL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333D18C02E
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746564; cv=none; b=VPU/kPmscVnlnkdDBa8r96Uyp6niQnKsUP9kxWr8My2ND2XQzh1nH+aTj3YRraNVlroU/ASp2YMKkxgblv02S5+/0KnK7jdsshOzxKLwuZ+tLUKs182sCXCjTQ4Xm+vHKT9/Vr69O5AdJPcH/Ax7eh5Bs2Dca0HiZbPrhYK6bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746564; c=relaxed/simple;
	bh=X/er2LoDkvUlCWyDSAEiyjLpPRF0VnQhqBtnxbeNMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltf+GSBjiKOWPUv4YYczrBTdohcIcbECDMzUuxq0XY/oeVW30tbyB+hTYef6oQL0C0VbHDMhd4+hpV6VzWISBoWUEOLXzivCenhdvO03gorn0ku0zAXG0O5feZk+5u5PA+db1fDnzA0ltewNPKD/cLqL7yuK5t/1Ufek4TUcBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL1Aj7VL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759746561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x4Ic6friOxCIiqjgkFZ1nAitS5y19AHJ4CH0PQv8Vk=;
	b=gL1Aj7VLbvaIJxVoEIvzzMvXo2hJVFoLBrs0iomJliWAhENc9wR50kA2E5B6MSyTgMTGu6
	GKGRNJB8fgeWacc7CxCSFGTxQSv4JE/SqsLJJvbduCFAtscXfI3Nispez3xp+dgi8LFbWS
	sk0LGviqF+RHkuRb8mm6c1jgujWYuAY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-71wynDNkNtOUZ1VoAz-i-A-1; Mon, 06 Oct 2025 06:29:20 -0400
X-MC-Unique: 71wynDNkNtOUZ1VoAz-i-A-1
X-Mimecast-MFC-AGG-ID: 71wynDNkNtOUZ1VoAz-i-A_1759746559
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4255d025f41so2851797f8f.1
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 03:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746559; x=1760351359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x4Ic6friOxCIiqjgkFZ1nAitS5y19AHJ4CH0PQv8Vk=;
        b=IYFswM7mJJAQA87LiPId8h2qkfQlk+YXln9m+vBbm5GiAbo56TNbvAm8zGFrc34IPz
         UsPnY09aFW3IfrF5TdyL6ihktKWpilusASuJ28Fm+ZRUv9vwrWqtAopDOP2F9h3pQQ9Z
         LS8hfo4qHOqLkyVk5NtZ1/+dpcBaTfi0vBCekYcmErOkDk5Wo1S+IPMQG5vopi3pBOyd
         nzueR2ZPCLQF/Pn3mFi5gkF8I7wPDeI94qWNoU+ZNSxlMhsJMDr96WrNujdCZTD4nqNW
         LUNehhLShbSPxTxBdPLk5g+yXFSmdiwUL/Ip1+FfjA5DvdQEUG/7jsaOMMcMcwhvgBJa
         JijA==
X-Gm-Message-State: AOJu0Yz/26PqO/J/XCYiO23ZQpBV3wRrfsWfuUNJB0jV2ehlMTrXZVk6
	0cfNR1IjvnRAUr9yq8vF3H9b6nK0k8ZtXoAyGrWZIW/phiSFjb697PWqNvaNrgiPC4dLmnR9oQk
	24UnmnFHwX0MXnQorN4e9X3vF/jAs3ikkPMAXi//JZuu48kTMRswabzAFGA==
X-Gm-Gg: ASbGncsNhOGOZp79t+RUfBhCUyovvwAkN2D3sqM/qm8jlFF6LNpsNOVMBR/GSS/9SSZ
	Dw8e0lQUzDTW7gBboFw7BG7xVvRlMi7tDh01Zku+ERJp/6PfBoAjoVd06Itjtod4zuyMpmZIziM
	4nuTO83leFNvho5uzIGYq6Ev8sNx5mxkfyHuj9nrf5QynJAa3RQvDSvHbnFxGcRl4E+Vcr52ejK
	yNj90yYbSbqAUwrUEhAUbsBvPjzoxHD4bRmNKmPWY6/NPoDCxQUXgtJZ0m4I7ijtZU3kRRfooqV
	KRGk5dZLU39isPvAx9DbuQYUrBZ87h/USGdlTkk=
X-Received: by 2002:a05:6000:310c:b0:425:7f10:e79b with SMTP id ffacd0b85a97d-4257f10eaa1mr1066569f8f.44.1759746559163;
        Mon, 06 Oct 2025 03:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tbvKRnrBj8QVt2nG5Eh7SlaXI+5atXG7MzqxwfWdVdeV+C+QICcLFfV8wDO9Tk24H1QpXg==
X-Received: by 2002:a05:6000:310c:b0:425:7f10:e79b with SMTP id ffacd0b85a97d-4257f10eaa1mr1066538f8f.44.1759746558652;
        Mon, 06 Oct 2025 03:29:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm20308787f8f.5.2025.10.06.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:29:18 -0700 (PDT)
Date: Mon, 6 Oct 2025 06:29:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251006062851-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>

On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> Hi,
> 
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
> 
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
> 
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
> 
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
> 
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> 
> Thanks,
> Filip Hejsek

But I thought we are reverting it?

-- 
MST


