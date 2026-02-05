Return-Path: <stable+bounces-214478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JA+EcqqhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8BF4165
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7090300610A
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43563F23DB;
	Thu,  5 Feb 2026 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x4KJ/VGN"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B773A1E90;
	Thu,  5 Feb 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302148; cv=none; b=i7Yr8j+fA9EGFFlly8L2nG9ZKYBVWrOS/E7VtRqHf86nCcUB2A3sthSnMA2JSP1+eNaWZKMaoYOX5ualsdoD8pRc6G7Oa/CSKKhU4LVCwr6PbjEu3+EwfbBLilHG0Iwf77vQxlfbDxh/ufgAuDKtP/T1yORKf8y2uZwWwHfN8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302148; c=relaxed/simple;
	bh=Y48v5F0uY2uuzpbh3pCI9xBz/nPqxmRlthztpqSa1eM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kNPB7iDVR6KQxDYd1iyi12Rbq3LsynIxgrkAyQiJRd7cqxwkbwR8/3hU9upTTq4SRjICt8OAWsC6iJG1098RELwtji+HU8uitHFtrwrT7x0M+Vkauqo5uvoXhtUQTF34tVeKrW9aNbOQcmQ9Ugp14ktGKOxfdVMZcWzlS/HIJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=x4KJ/VGN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 615EZ5NX513827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 06:35:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 615EZ5NX513827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770302107;
	bh=Y48v5F0uY2uuzpbh3pCI9xBz/nPqxmRlthztpqSa1eM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=x4KJ/VGN3QLs1138UJyyt2zgPxW/1gq+c/TR3YpWwOjRytBxHV+x4dNiR6T9tqlZ+
	 7YmnZwzUuykKVyYykHHwQsRsKcOhcRTocdOkVjnuFSj81NOXrRFG2OaQ+0h5apQZas
	 g55bJd0GtsbTMMMu85vjqtQZHU7WCPCXl8TgSJHw81uncpKWtT51GJ7v84lVCjLAxi
	 6N/kpnYpnuaIQEAlkL+oYhR4X33fO7diI1E1HBk4CgtAjpWIjE8/FlYus95ezxeFrm
	 iy5VwzJuLMKC8E7iK2N5nVBWWZHx4B0PPfX2u2T4L42hiO2cwkLnKcGic71zfoa1Bt
	 0b8mpkhJO96Yw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] x86/fred: Fix early boot failures on SEV-ES/SNP guests
From: Xin Li <xin@zytor.com>
In-Reply-To: <41a68344-e2e1-42f3-82a9-1b88cd4ba4d7@amd.com>
Date: Thu, 5 Feb 2026 06:34:55 -0800
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, tglx@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, x86@kernel.org, jon.grimm@amd.com,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7C8EB84-E706-443C-8038-64DA7B3CD132@zytor.com>
References: <20260205051030.1225975-1-nikunj@amd.com>
 <D313F34B-8463-4D48-B09C-07322D6808B0@zytor.com>
 <41a68344-e2e1-42f3-82a9-1b88cd4ba4d7@amd.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214478-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[zytor.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xin@zytor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: A7C8BF4165
X-Rspamd-Action: no action



> On Feb 5, 2026, at 12:54=E2=80=AFAM, Nikunj A. Dadhania =
<nikunj@amd.com> wrote:
>=20
>>=20
>> Can you please check if it works for you (#VC handler is set in the =
bringup IDT on AMD)?
>=20
> Yes, this works as well. With your change that moves cr4_init(), I no =
longer
> need my arch/x86/kernel/fred.c modification (moving pr_info() to avoid =
the #VC).
> SEV-ES / SEV-SNP guests boot successfully with FRED enabled.
>=20
> Are you planning to post this for inclusion?

Yes, I will.



