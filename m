Return-Path: <stable+bounces-118390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6063CA3D34A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C474189588A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CCF1DE2BB;
	Thu, 20 Feb 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtCbhVaX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE51C3F02
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040480; cv=none; b=FGHR+yKiRlPse77Ns5jzek88pyfw9qwZOafWpVPKYpPTsg6uEXart5HpIsfMDNyarxN9zQPa+tUm6NBl436lBoiu+E6rjS1PNLaVVbWlrN7kSk0H+lHKG102P/ne14+RZnYD/nf90zA4LmUBPxv/D1CjdTXWuA6/W1c8G+A11pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040480; c=relaxed/simple;
	bh=3+oENpwRDs+sCI3Wq9VGfiLXW/ZTSzz2ePufFN+kK70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T4PhTNnF5wwvinHfmJhXp1uvricVQ3p/xTw8KDiac0HXWmc6/zQo/KdNfjXUaURBUUHHNoYcwBoVHm8nzeUa2lMAsL+9utJznXoRXBdRAmQN8FDmpBKAFmCJrzbu2hP7OK316K/a5SMsO9L21C+sOvFBSGuO7r/wzCOELmsC5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtCbhVaX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740040477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KXXtnuqQuIC2Z7n6mNbXVAxt7b7CZve7AHdS+WnlWX0=;
	b=QtCbhVaX/GSiIgh/YfO3/WW5PBgR82fGVZ3xw3KDMhzNi1uPYtFYSK3OV8UEeqpTEJBYwM
	Rpj5P7t5k6+Y1WTh3nUZRq7lfX9GFLpmFfIk6ae/52Ojqev1E3rlIt3GDsSwVx+T12guhu
	BtFybMtEcw0xK0j9KzIjIzvDs3iPtNU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-gBVjcoh1MoOJbKDe-J0BEg-1; Thu, 20 Feb 2025 03:34:34 -0500
X-MC-Unique: gBVjcoh1MoOJbKDe-J0BEg-1
X-Mimecast-MFC-AGG-ID: gBVjcoh1MoOJbKDe-J0BEg_1740040473
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4bf0d5faso366044f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 00:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040473; x=1740645273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXXtnuqQuIC2Z7n6mNbXVAxt7b7CZve7AHdS+WnlWX0=;
        b=jCcTokBC3omeZ4baY9kWaaWnsP+I8C1JuZH2mY8bkLiqwzArZtPbmgmNb95o5AQzK/
         8Ye83HIscUvOkB4vUjZ75WC66CCUQfQb7B3G14kf/9IfOsDJjaG/1LShf7ZqSBaKjFFy
         cBrTnv44mJSRXPVDPzKiUvdZmU2/i89y5KZyPRf7DG7oJv+FpNTjj4OrcTkC4snMAZJ8
         2qNvWRpUkaR+sSC/pgnQGAmRru4ArTy9AKxk6RIY+06/ag6EirnmIt7Fw8LqtZ/ugQmT
         lAo9LqWbRFq92ojZPZUtYVtXJmyfLYfyZt8OJddGh21Z3VUO7MgStcjrL02aWsgTYpbt
         sXhg==
X-Forwarded-Encrypted: i=1; AJvYcCXI1nAd4XBepSJwd2G46py9r3CKK5YHc48f/Y1G0iKRsyt9CAlYj28MZQOmRzjkj4bLbs8VGAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzWGEMEfxjBcdUAEO13d9+YxqU2upfEVfuqeir4eO0fXohbDP
	lil0MD04t7sllORwuW4sT8BuCeC6SeMOP1kADSu1hmgK3kfUyfeOp0ejXjauVUkm7Oy76yF98Mk
	LIn2VEwcO+i7LjYkfmym9QjTAtk/t8YfKqKdi7Ou5KUGQLeRQ2b7pnA==
X-Gm-Gg: ASbGncvmfPh7mwcpPtAYt8GFqcAIx4koi2m0r2l70HDpRbKGmabT9/3W4FfSwSmUPWo
	TKhjbQYQuY3i7plpggSZjcVZm3Jam+p3Tw0SfEVntMMfAC5cfMT2BMfSrIUPPF6HKJJIO5sBA76
	DDcqXEpx+F6e4g+k5+BBgtXXaBSZMSeUs+/bZn2IiBsoZKfA8BThkOzwBQvk++CMlOLnz7wah+G
	damUGTwi5m2GXGDvMUbE9JEjAL01RnkYaJOHZGQX5Qtv1Mno68emX+n+ndOXDxxnMdIFpQKd90l
	r9Wj4RT3
X-Received: by 2002:a5d:6d8f:0:b0:38f:3d74:9af with SMTP id ffacd0b85a97d-38f587f3a49mr6263045f8f.45.1740040473111;
        Thu, 20 Feb 2025 00:34:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS0fHglvgrFd87Roba0QHESWPhVtKfbZAYzZQZbVEWWMDV/JTGnxZgdVD9ZOEKhukdZmnLAw==
X-Received: by 2002:a5d:6d8f:0:b0:38f:3d74:9af with SMTP id ffacd0b85a97d-38f587f3a49mr6263010f8f.45.1740040472716;
        Thu, 20 Feb 2025 00:34:32 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44b2sm19699293f8f.20.2025.02.20.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:34:31 -0800 (PST)
Date: Thu, 20 Feb 2025 09:34:29 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
Message-ID: <ou3e63wc7vb3tob7roidzfddk5xvg22qgctixdzcwoeli5yky5@5r6cxakuxdyj>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

<qh6envvnuw45w2omvpufqtbq5k5343ymdzswxrxmczwoe64d6g@a4z5wjdbdw6w>
Reply-To:
In-Reply-To: 
<ah4qm66q5q7we7ykhl3uywgrexi7izdxrmfyn2zm3jhswitebt@cz2ipkdgr6yf>

On Tue, Feb 18, 2025 at 05:01:31PM +0100, Stefano Garzarella wrote:
>>
>>No, nothing I can think of.
>>
>>Note however that the comment above vsock_close() ("Dummy callback 
>>required
>>by sockmap. See unconditional call of saved_close() in 
>>sock_map_close().")
>>becomes somewhat misleading :)
>>
>
>Yeah, we can mention in the commit description of the backport that we 
>backport it just to reduce conflicts but sockmap features are not 
>backported. I'd touch as less as possibile in the patch, otherwise IMHO 
>is better to just fix the conflicts in the 2 patches.
>
>Thanks,
>Stefano
>

Totally agree with you, will send the backport in a couple of days if 
nobody has any objections.

Luigi


