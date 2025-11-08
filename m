Return-Path: <stable+bounces-192774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6DC42A06
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6FE24E4755
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD72DE70E;
	Sat,  8 Nov 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zfvqq7OI"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6631D61B7
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592955; cv=none; b=dQmIlbf3Oh/4SACOU0/LrDGJ8HAd23ApIxkuzBptKphfSVBgeDlrmKjgw2+YRZRodJk1ZHs/Wr8v2t2Gu4aT3I75adZP9Js8TlCGtTYpSdnnxFFSM0vHeOQ+48owVvjSjiwlAFcmyElksWIVQNk0ay0jNZgvoGQ5rcsCcCislLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592955; c=relaxed/simple;
	bh=ac9IS7LxhGvsJ5M7ao47Xp0eXk3OFOlfbqAMvrPtePE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kQkOd39/QrgpXBQQjCd9iAJaIRYHCIj7ROIoiFA5Mq8L96GHp6HImtDI4qSMdh295LZclK0z27CCn3XHNXL3aU1rbC6ahHPSbczlVxr7ve/uO8Q9mgqrLcMqdUdNa334ayErKlX6SCS9VMtVVz03X4+I8sE+kuWSYvBTSZDKYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zfvqq7OI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762592941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac9IS7LxhGvsJ5M7ao47Xp0eXk3OFOlfbqAMvrPtePE=;
	b=Zfvqq7OI9pkjpiJOrYomc+ls+98QLTL/pSq9xUOjZjJVPdkNowl9gQav1VxF6GlDQcSVU/
	mFg6UEjC/0myT6bcnk/pTfd5m3iJduwhS7Jqb4hoZAG4auxE75Xx/IQRpbW7ESbJMvJHL9
	F5Wc0q8Ooe7P3d4n1rDliQmB1Q3N80g=
Date: Sat, 08 Nov 2025 09:08:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <3759161383b53759888f64d9a03983c05026ab1c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 5/6] KVM: SVM: Add missing save/restore handling of LBR
 MSRs
To: "Sean Christopherson" <seanjc@google.com>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Jim Mattson"
 <jmattson@google.com>, "Maxim Levitsky" <mlevitsk@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251108004524.1600006-6-yosry.ahmed@linux.dev>
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-6-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT

November 7, 2025 at 4:45 PM, "Yosry Ahmed" <yosry.ahmed@linux.dev mailto:=
yosry.ahmed@linux.dev?to=3D%22Yosry%20Ahmed%22%20%3Cyosry.ahmed%40linux.d=
ev%3E > wrote:
>=20
>=20MSR_IA32_DEBUGCTLMSR and LBR MSRs are currently not enumerated by
> KVM_GET_MSR_INDEX_LIST, and LBR MSRs cannot be set with KVM_SET_MSRS. S=
o
> save/restore is completely broken.
>=20
>=20Fix it by adding the MSRs to msrs_to_save_base, and allowing writes t=
o
> LBR MSRs from userspace only (as they are read-only MSRs). Additionally=
,
> to correctly restore L1's LBRs while L2 is running, make sure the LBRs
> are copied from the captured VMCB01 save area in svm_copy_vmrun_state()=
.
>=20
>=20Fixes: 24e09cbf480a ("KVM: SVM: enable LBR virtualization")
> Cc: stable@vger.kernel.org
>

Reported-by:=C2=A0Jim Mattson <jmattson@google.com>

> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
[..]

