Return-Path: <stable+bounces-65306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39B94649C
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC451C21666
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690A8287A;
	Fri,  2 Aug 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD1zXcxb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925B7D07D
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631632; cv=none; b=sS6eIJUOCm/2bpHKSHErN+OakR5QxU7L5LhThB/3zGrOEz9xhJNP+cXZcm2BsJ6GWkNac3mHJGsHS0eBJBkDq0zV/899VO8XYqM76nnCMU7p++BpMceID929JAN4BpoPRnRoczMNrs8AcqxQZLCHC0iwDJ/4sq6Iiyv3vOTKD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631632; c=relaxed/simple;
	bh=nOk48cFkjllDvibgzssjyX9TJxSU2CPtgkQ91y8in0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W4INa/4Na5nO2vU/2KrYStURnpBDgtZ6WxIAjhX/XAcZ7mKw8IC/IZ9hnecNrcrKz7kTQOipic/KrgBFB8JLdJrYIstVUgo2u+kqSSUWyY0YfqQYu+s8DF939mdbRrn27RBdHWxXiEQNw+M8QBukDb5f4aqG676j3ao8H3p6pzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD1zXcxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722631629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tXvK1vsGBENe1Z3UKUTgGBrRGiZzL2b18cCvo7uxGDQ=;
	b=gD1zXcxbSQoK64nWUZKihwF6xxoehnXA0Nh8RoaUvkG4Dy8u3VlTnB5V4MwaMpAgIcAV+W
	6lVFqMslr8sAffgEh1SN62TMlDIGD4MFb3zBF5vUhEKc4TNayMJ9iOVsEOFVUl90m49DTA
	FX5/fkPdOLLkwlWN7AoSa2bHvM0186o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-rhHExSb2NLaZ8uPUhidjAw-1; Fri, 02 Aug 2024 16:47:08 -0400
X-MC-Unique: rhHExSb2NLaZ8uPUhidjAw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36831948d94so4592719f8f.0
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 13:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631627; x=1723236427;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXvK1vsGBENe1Z3UKUTgGBrRGiZzL2b18cCvo7uxGDQ=;
        b=gcTbA9q9Toogb8N/5kA64YEImGKp5bomqPD0eIJczeJmOmAvlGrrwE2tl4laT5TtzS
         qxkjcHkqAYv+HvhqIWR6yfhCGi8hz89sLBXOCZUUiFGoARw3WR9tpQG9g0TmX+K4wah7
         2NS1mDVe89dXwf1aa7XpoYsg34P1xE+L8mCD2fGYlQuwADLdgB+Iu+F75ummPVHlIrAU
         awU/eWLhCamAEQWvY7ZAOXe7GQ0I/ygXmNQZ7RM3I9Y2dH4dA9XoceEQ2vCALFddIhK4
         OVItw9PWioO4xZGFmtIx+lhS4fEf5O1M4/HkYdukfQ5PcxYSksklkhzUxbERNY4vFrA1
         ffQg==
X-Forwarded-Encrypted: i=1; AJvYcCUKADPHq1cfsaUP9y+VA+7IHagRbag4zcbbexfCmpExD6XauBs88ItiyZ9bDrBA+8V3YhKCcRUbS3KU3qmXnkkpMPAkqGtB
X-Gm-Message-State: AOJu0Yx67xN9rvj76C9JEJ3RL4weCaIHZANbNuWIc1cB44EccPn6VQNh
	mq6UHKJjlkAhvNZBO1ri66GM2VUCcMxdMil96hQQA4cGIk6TYDaad5Lzeha2CNxqinb5GzLLpKl
	T75UwPgzq9MVuCn05MLf3NdICTH+8yJ0fMul14zho9PEdlCcUXFgDOYLwIIgI8H5PKd/0XlVx0g
	kWDH7mV+LIB4JzkFyf8GCLflOfkqGk
X-Received: by 2002:a05:6000:d2:b0:368:71fa:7532 with SMTP id ffacd0b85a97d-36bbc0e7225mr2566331f8f.31.1722631627435;
        Fri, 02 Aug 2024 13:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEln0HFWUnzDBZmzcRMtD0Me6jQ1f9XOaXjFPjA/wfih4jpNdvcWt0d9WgeSlaj4N6hRqB6cmklfiFdewCD/ak=
X-Received: by 2002:a05:6000:d2:b0:368:71fa:7532 with SMTP id
 ffacd0b85a97d-36bbc0e7225mr2566314f8f.31.1722631626654; Fri, 02 Aug 2024
 13:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Clark Williams <williams@redhat.com>
Date: Fri, 2 Aug 2024 20:46:55 +0000
Message-ID: <CAMLffL9t0SFkO90d6pFZAwp-WVbont7NgELx_WW-GRRYkF_QXA@mail.gmail.com>
Subject: CI build failure in v6.6-rt
To: "Kroah-Hartman, Greg" <gregkh@linuxfoundation.org>
Cc: stable-rt <stable-rt@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	"Claudio R., Luis" <lgoncalv@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Greg,

Kernel CI is reporting a build failure on v6.6-rt:

https://grafana.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=riscv&var-build_config_name=defconfig&var-id=maestro:66a6b448bb1dfd36a925ebef

It's in arch/riscv/kernel/cpufeature.c where a return statement in
check_unaligned_access() doesn't have a value (and
check_unaligned_access returns int).

Is 6.6 stable supporting RiscV? If so then we either have to fix that
return, or backport the refactor of arch/riscv/kernel/cpufeature.c
(f413aae96cda0).  If it's not then who should I talk to about turning
off riscv CI builds for v6.6-rt?

Thanks,
Clark


