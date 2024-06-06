Return-Path: <stable+bounces-48253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD118FDBFC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 03:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E7284532
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 01:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A7748F;
	Thu,  6 Jun 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="R3+CQ+dg"
X-Original-To: stable@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D009CA6B
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635690; cv=none; b=JyhhkAeQ+gHviHGkch8HEEesM+Hm2ABSFIZ8GzJgNtSJFdmAfNoC1LlwRPe0tZFKaMfK9W7ZkIo6RJEJLVe7yNUPMKv7tePghPx9s4WSTTbzpOuTysyKks5xdfPl/98AqnFHoxkVOnKU0zUylaJonCHFG8luiyBef4BVOdCO8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635690; c=relaxed/simple;
	bh=WfW0iDxYmYUIcxa3+/dC/7LsSHJsBqXDLA474zSAgwo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=PMo5wvEiK/n+6ijU7GtVpL4OatTjJ4jUHahYKWl6wLtSnUTEZ4c75VFecgVqK8cd4TvVzZxDStgDUGICI3j7EVJK/hF3veg/T4zpHvQIy1q2opIG09nXcR8CT56gyLgBEtgjsk+B67J9Wzq1NAYzmXA549jz29w/lpQublUBpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=R3+CQ+dg; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id CFC228286FA4
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 20:01:27 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2VFYDikC4ytw; Wed,  5 Jun 2024 20:01:27 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 648ED82858AF;
	Wed,  5 Jun 2024 20:01:27 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 648ED82858AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1717635687; bh=WfW0iDxYmYUIcxa3+/dC/7LsSHJsBqXDLA474zSAgwo=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=R3+CQ+dgG4LrqLeA4WMIDLcJLR+7MxISPiCBULL9vqWwHK3o1GeBhy+sZiVqVuYBc
	 tPwIRtMxFbEbytlqyL+eoOv9sqWkewmkJdFsHHsZl7qtcCk4oxVKPDTru7Ojgx/Bz8
	 vzy0xVhMRbW84ef5NM4AFXHaJurhgHVODuMS7UUE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nkE8dtAyGUU2; Wed,  5 Jun 2024 20:01:27 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id 0026A82856E0;
	Wed,  5 Jun 2024 20:01:26 -0500 (CDT)
Message-ID: <b7df9808-9a26-4e80-8137-d72e392b177e@raptorengineering.com>
Date: Wed, 5 Jun 2024 20:01:26 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: stable@vger.kernel.org
Cc: Timothy Pearson <tpearson@raptorengineering.com>
Subject: Backport request for "powerpc/iommu: Add iommu_ops to report
 capabilities and allow blocking domains"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Commit a940904443e432623579245babe63e2486ff327b ("powerpc/iommu: Add
iommu_ops to report capabilities and allow blocking domains") fixes a
regression that prevents attaching PCI devices to the vfio-pci driver on
PPC64. Its inclusion in 6.1 would open the door for restoring VFIO and
KVM PCI passthrough support on distros that rely on this LTS kernel.

Thanks,
Shawn

