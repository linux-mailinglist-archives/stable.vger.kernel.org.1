Return-Path: <stable+bounces-86488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80119A08DF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6481E1F210BB
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB0207A2C;
	Wed, 16 Oct 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdKtOuHv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323F207A0B
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079781; cv=none; b=BvX4SUHJ8gF+53yvR9oBOBAfkMvWaSpNMyp9nxTuXRXMRE9z0yCWAG13GEYpsPYpY588eyaN+27x3bQFkw2Ph7OVLGX0UUzaNCelP4l1Gx6+bYxo2RkIpfbOeM14FjtsS9HcCzwS8BexrA+JkOsWFOKnQiQq77lfaYsNyTd0p9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079781; c=relaxed/simple;
	bh=ZE6tSbBnrgSxfs8hfG9pixVaeQvAehA2fgnct8qkbRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Rma3OIarxIpN7TgbgWLScs4qbQFP2P8QxVl4ycnAZfUDU6sg/5P+5gRuI1Ych5xty+W8R3kpyXgGm5gHwk8w2mtiqS6R9wQ96rDrwr0rDQTvSJauSGpcuanQnBB0JHcpInqVOzjw96hpqnUcgs1Wo0waAQwli7MbSzJ5BZNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdKtOuHv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729079778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE6tSbBnrgSxfs8hfG9pixVaeQvAehA2fgnct8qkbRI=;
	b=QdKtOuHvHPDX9B+M1h+sQcVYiJyac6xJ3FPvzgKDgKUiGb8OozpqIZ/n+itcuw3kyDnjJa
	c4EzM6xg+j30mFCZOBx281AHnTQPvmHxXSBFeoT5g/myZLNGlOsDK2G2pdkqipxlmzC6Xn
	KHL02/Fmt85DsHrhPFbMpIJ41hVYA1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-Pa8X15QgOwyDlrPk5r75DA-1; Wed,
 16 Oct 2024 07:55:44 -0400
X-MC-Unique: Pa8X15QgOwyDlrPk5r75DA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45F7C195608C;
	Wed, 16 Oct 2024 11:55:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.76])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC7A51955EA4;
	Wed, 16 Oct 2024 11:55:38 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath12k: fix warning when unbinding
Date: Wed, 16 Oct 2024 13:55:35 +0200
Message-ID: <20241016115536.204583-1-jtornosm@redhat.com>
In-Reply-To: <2f6f7649-772e-42e6-a762-f2d66b7e3b22@quicinc.com>
References: <2f6f7649-772e-42e6-a762-f2d66b7e3b22@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Jeff,

> this test is unnecessary since kfree() already handles NULL
I agree and normally kfree behaves in that way, but in this case the
warning comes from free_large_kmalloc. Unbinding from VMs, the warning is
always happening if the previous crash is fixed (first commit of this
series).

Thanks

Best regards
José Ignacio


