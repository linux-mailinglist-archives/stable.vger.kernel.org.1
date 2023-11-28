Return-Path: <stable+bounces-2896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304B7FBB02
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5337D1C210F6
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EA56765;
	Tue, 28 Nov 2023 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxYs+qq6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6230BD5D
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701177150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qXxb/9aW5dF9T0+/0/0Z8yiaKkAgv6wDXHWvegv7WGI=;
	b=ZxYs+qq6e6NEpFlgJvJo1Z3AHGiuJ7pFNK0zdUr0NEjbkjwImr9DOq62rLINjITaQaA/YI
	Kzruf6KVa9dVGPNEpkSJrrlh20Nmze3qV1GsCJWnSsNZGTJobHM87vsdybotM8+TYN27Mn
	NsWZ61VilcgLtzGTTJiUYHxP6aLv8iw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-D9dHl6JlP2y09cjXCz0Pdg-1; Tue, 28 Nov 2023 08:12:29 -0500
X-MC-Unique: D9dHl6JlP2y09cjXCz0Pdg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-679ceb85c6cso79606326d6.0
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177148; x=1701781948;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXxb/9aW5dF9T0+/0/0Z8yiaKkAgv6wDXHWvegv7WGI=;
        b=JnVofhQ+mWubIkiBrNGKTc7n4ycGQFKiRkl1sAhJiYXYsncH5DmFMhLN0CUBaQCrN6
         N66kEMaHk97txMldTMs9PeeaDdDhWHRWFwxdm/RvUnMFwwhWxJOXrwspmqdEudsn0c4G
         412CChU0+YnFbpBk6TFtWxtoq4z+LNOB8CscVzm5k1YQrdmJ+8+VQFs8LAv4082hJlUo
         1Jp+GuhzcYxPAsw2YRZ+lidGrFE9IzdKd0Zwqr1gK4Aozjd6nhl5BZnyt4zo8fV0LM/N
         fwszAnEpjMQwpehKr1S/YOkAiKhWAaoXQWTGsZBAYIRUjj9R12MVbT9cagSbMOi1RGZ1
         r3wA==
X-Gm-Message-State: AOJu0Yxnkg1z/Dx+M8QtP4edwDAPhLcf+WgjcP7kcardy3KCCLXzk7eZ
	+Zc0HM/2peWWBTIsaAAfVHoWPOYlBImnObR7FYm9eFDiWhQoxKQh61PS5096EFBNpEuGWwhHJHj
	WlfzW2C0HlANQ3iNh
X-Received: by 2002:a0c:e605:0:b0:67a:1c5d:70c5 with SMTP id z5-20020a0ce605000000b0067a1c5d70c5mr15510086qvm.51.1701177148782;
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhwLeA3QAWHZn4/cB/3/RUlVLlqRRrnC6QUTwMYyMqk3FZk2smhrubfPC9mUZkQIXyXo0ykw==
X-Received: by 2002:a0c:e605:0:b0:67a:1c5d:70c5 with SMTP id z5-20020a0ce605000000b0067a1c5d70c5mr15510075qvm.51.1701177148595;
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de. [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
        by smtp.gmail.com with ESMTPSA id ph25-20020a0562144a5900b0067a18544c41sm4095166qvb.58.2023.11.28.05.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:12:28 -0800 (PST)
Date: Tue, 28 Nov 2023 14:12:23 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
    Sasha Levin <sashal@kernel.org>
Subject: usb hotplug broken on v6.5.12
Message-ID: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hej,

usb hotplug doesn't work for me running stable kernel v6.5.12 on an AMD
based Thinkpad t495s. Bisect pointed to 7b8ae3c24ef ("xhci: Loosen RPM as
default policy to cover for AMD xHC 1.1") - which is 4baf1218150 upstream.

Reverting that from 6.5.12 fixes the issue for me.
Current upstream rc kernel contains this patch but doesn't show the issue.

Regards,
Sebastian


