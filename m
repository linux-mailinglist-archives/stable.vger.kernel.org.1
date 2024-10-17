Return-Path: <stable+bounces-86578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBD9A1BC0
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74D01C2218E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625241D0488;
	Thu, 17 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh4AGeEC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF31C1ADA
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150553; cv=none; b=Q8cKnWI93L1D3+T6AtNdrabcK2YR0A5zOUvemMgkFbP9hVAukdScvkuZjAaXzjWXdAxLtloHUpR0BhXk6LmHq7yjKe9gTUR/glPQCd8QxbZG/hvdgQ7uUTN2wLGjqQbKvPZoy2NLBnURyb9LaNSt44HqBJdt5bPEXwmIiu+9pGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150553; c=relaxed/simple;
	bh=ekjP/+RTxRRpF924txgjW8HefsPRSKOo9PCJDVuif4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okujtZfRhDeUKXCDbQ4PCZN5B+NlDj81+eSHvIcqaJc/TOkGrdnvJF6g7PThM/N+6ws+HaEMpvyDpBQBD6FhCljFEOvn8NrnPW4EwovAgSAR8hC6zi2T5KGPF9s1YJJBQ6C9JlXvrFfS23c+PBXCA5awkylO88Z1xS76qykcaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zh4AGeEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729150550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekjP/+RTxRRpF924txgjW8HefsPRSKOo9PCJDVuif4w=;
	b=Zh4AGeECkJ4PvHHhFRPsysqTD7nFRThCN62eoA8xmJ3n9ysERUdY6bEsQPsKSAc9D7zkQi
	Qrfct5GRho/NR8BJaM8dIXTDyhzUqo4bBj0CEtYhicOBBAoUqBXSeK5+fBPciV8eTYXSyw
	inVk3VSHPWyq9NyZd7BiwxmtkTivpB4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677--NNdpK-0Plq6hfaZ_JTfCw-1; Thu,
 17 Oct 2024 03:35:45 -0400
X-MC-Unique: -NNdpK-0Plq6hfaZ_JTfCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B241955D91;
	Thu, 17 Oct 2024 07:35:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B46D19560A3;
	Thu, 17 Oct 2024 07:35:39 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:35:37 +0200
Message-ID: <20241017073538.176198-1-jtornosm@redhat.com>
In-Reply-To: <452ec614-7883-4e0f-ae0a-25d22d0be41c@quicinc.com>
References: <452ec614-7883-4e0f-ae0a-25d22d0be41c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jeff,

> FYI I didn't comment on this previously but
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages>
> has some guidance on trimming backtraces in commit messages.
Ok, I will trim the backtrace in a next version of the patch.
And I will fix the typos too.

Thanks

Best regards
José Ignacio


