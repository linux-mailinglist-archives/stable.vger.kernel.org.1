Return-Path: <stable+bounces-37776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9F89C884
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265F6B2314E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C91420D0;
	Mon,  8 Apr 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW7uc67/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB82561F
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590702; cv=none; b=HWeewh6KqhZdTfCtIoKYpKxPXa4gHcsmdvqD1UWMINX+QB1uDMgdSfilRVXg7vFglBEPdwkkLAoP2xGAWjqreWPcaY3QT1ITlr8AGoVzhFhQdQrVbHH+saP84ziozlEhGRcfdpfCWL7eyFbidfCSVxS/1jTlDaVKLo04sASFFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590702; c=relaxed/simple;
	bh=6IXLTjcd6JqGOQbMDKa8PWG/UBTHXWFqxs/wZfO8js8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy9snKSnHYSh2xxKtpRL2OF18njLupubmMMqoJT7LBBuXArUFyhCKrWREar2/I0L8DxkbNZqGui24sJcNGh7Fuj5STPPBSRmZc9q8aWqrhiAPwwPKdF3CGkLy9xivbtX7KcaZhoDxkPnTHxYueB+8nvKabpuqNv46v31fEOT2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dW7uc67/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712590700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IXLTjcd6JqGOQbMDKa8PWG/UBTHXWFqxs/wZfO8js8=;
	b=dW7uc67/MDohw5FjXKnHaOnxe8F5mc9AwN0mXnN+3cMBzC7sOKNS54eTZawksewgpSGMst
	1KnYx5HP6h5TGjqvSxKhL9acsUZHOmfD/CqOUHZ2DPVHb2QvvNCJQ810yHQJFI08ldfYEe
	FaIfPevvErTiR60WpALNqaXtW7/MWXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-x-K6YrKdNeuyXnMuSmr1WA-1; Mon, 08 Apr 2024 11:38:16 -0400
X-MC-Unique: x-K6YrKdNeuyXnMuSmr1WA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D935800219;
	Mon,  8 Apr 2024 15:38:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0012F492BC7;
	Mon,  8 Apr 2024 15:38:14 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jarkko.palviainen@gmail.com
Cc: jtornosm@redhat.com,
	linux-usb@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [REGRESSION] ax88179_178a assigns the same MAC address to all USB network interfaces
Date: Mon,  8 Apr 2024 17:38:08 +0200
Message-ID: <20240408153809.620467-1-jtornosm@redhat.com>
In-Reply-To: <ZhFl6xueHnuVHKdp@nuc>
References: <ZhFl6xueHnuVHKdp@nuc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello Jarkko,

So, you are using two (or more) devices in the same machine and they are
not getting the specific one and even they are getting the same locally
administered address (random).
It is strange that the second reset is affecting, because the read and
previosuly stored address should be the same with one reset or with two.
As the author of the commented commit, let me analyze it to try to fix it.

Best regards
José Ignacio


