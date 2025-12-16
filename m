Return-Path: <stable+bounces-202716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB7CC4792
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284C93067D0B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAAE35965;
	Tue, 16 Dec 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="krKxNl8V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12E2253FF
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903852; cv=none; b=ULpFWe+4EmFexN6S4uRd/A+oJvL+VJFOABe0jyJmnISl7kED1EhqALtEdfxS0890AB/XKxpJvWHp+FUGdsN8aXpaYHPv8IszLShG0vB9an5Az3QvVu53BDUn2FX3sgP842PhqS1zZTtaQ31Dhhy3sFByZo+gdd227looPojCiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903852; c=relaxed/simple;
	bh=Smh/tQsIRGlbZAi61bfDmFse5QSWYx5lREMDcGg9uHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UknvVeU7t5GUSjaXSWmj3LJJ1PXjXkFcsrh86nZnwhEXWYXRzMmoj0+Vt7EKl9mO8iCsP9g9twK2Rdb0qYzGXh4uY3pmyHQkDOWxtVCrW7stwJyjoPWNOUP8qoJdheEOBK7dIo8oK5D94a3uxIP0KNUdB2y+UP9VqB/vvx6VnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=krKxNl8V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f30233d8aso47746555ad.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765903850; x=1766508650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6+nRXGAT6SHTmSU3/EOsL2PBk8Hk81U76K8Jyll95c=;
        b=krKxNl8VUubZppMjXt04Rs1Q0EMIAFJMzr57hbti6FphXUhvuG451N4QwgZO80eSgj
         0TBjttcXHxN7PtRiNSsRF8ocVq0WR5m8g6S+bw77dhV7AL++yEDuSZQD1wUv1fzACUfF
         mwPWM2acYsqZG/MVEp+v7pl2oUzr7QU/RxJ35Qfcm9OjSHWMGSCeDE90/PY1Xbmq/1TT
         Pvfmu67C08ygd2H6vnFwMSYxpQE1O6WLtLzIcdRz48jpsrixm9HKhSuG/lN/bMNKgTTz
         rSfOfXGvkA9gzCFel673OqFvlHy72iK2ZZfx25p/MvYy1OLYfnAj0iP9t5uZxLk67SG1
         Hyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765903850; x=1766508650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6+nRXGAT6SHTmSU3/EOsL2PBk8Hk81U76K8Jyll95c=;
        b=YV2EcPVM8APwiCAi8fGC7sjK7rWU9agdEdQzmrxmh8LUj/FpcCvYjnuaSYPjmAzMzt
         kDNZ+fPytQ3W5X6l0QrG02zbYnqVpR+E8CnQJx6QwZ5DTuRn4aOuwrOkWWd7pA06rTwX
         uTxh9oat7Gu6unCi7OZhxvsjbs1CUIbFy7IVcVPSpXgHGLh/LJ5ui1AW0vjyTGpGRsVo
         lmSbee1Z0PaITDOqKcaHl2F7D81aNjrDGVadDU5IjPoIwlnUc3m3zBLEvstteuvujuXO
         y962nzMuem2bhxxdHVFHxb829QLc+7o4kxrLD1EtMuuvRP2DXVk5QRZsDq9EDzq+Obg0
         QPTQ==
X-Gm-Message-State: AOJu0Yw2c3xuNF3A0zxsHK0kskF0hJUpGmHjQmJ6kmiuTzQkdKnhVD7f
	1lqlDQfLLWD7KyfPaLZpspezIm/votZl4GDFoAm6/KBSTRTqNyNpVcN5wSVWCUUvSQ==
X-Gm-Gg: AY/fxX4NZC82b4TfN/O0LNxtSsJwnnM97ZEgyN0CtcKAVqLf9crJNkvo+0oa5IUWUF2
	4P6ir93pjkUcVGHkAdQIy0+Z3tZ7ivEWSBKtIwPjq42EJH0PeDzebtruEy4ox7nxQbRdQ3DYVWZ
	MCXe95AHTBGRFnQlipNmx9r7ggUMdg/qwyN+F3TkJ1P4DpGIepqFI5v2o5Wg+u3XhdjA3Vap/GG
	TEEnw9NsA2VwV81xE/CfGThWzVBlgcQbe24Ai+h1bx365D5eB1JOnis2AE7+lYdxmG86APH+Knp
	84NHtV88w2cFWdgJw7NSw1vHQ9OYKzMRDBOWjhvNpghSwtTPLo+eOlcXlI5Pi6NjbWQsjYCPIKl
	gafssh4D9OLP4WQbJUZ5vAw/nz+st5zuBY2h5dEHwyeuiKilTt2uvMwCv4wowomurXysWg+9B4q
	FkvyfjfKgh9jbgNu/yUYsKPenLunVpRyxO
X-Google-Smtp-Source: AGHT+IHg9Xzw4Y9VGKpJnu03g96Os3VcwZ/ZN0WjT5o4NrajdDsvndCrJsPtMVIHfYWTuO1svkiW0w==
X-Received: by 2002:a05:7022:f511:b0:11b:9386:a3c3 with SMTP id a92af1059eb24-11f34c395a3mr9496061c88.46.1765903849986;
        Tue, 16 Dec 2025 08:50:49 -0800 (PST)
Received: from gmail.com (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b46f5sm53469100c88.5.2025.12.16.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:50:49 -0800 (PST)
Date: Tue, 16 Dec 2025 09:50:48 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Oliver Rosenberg <olrose55@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 240/354] kernfs: fix memory leak of kernfs_iattrs in
 __kernfs_new_node
Message-ID: <aUGN6G0v6bi8joVR@gmail.com>
References: <20251216111320.896758933@linuxfoundation.org>
 <20251216111329.608256836@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111329.608256836@linuxfoundation.org>

On Tue, Dec 16, 2025 at 12:13:27PM +0100, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.

Please see https://lkml.org/lkml/2025/12/16/1248.

