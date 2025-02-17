Return-Path: <stable+bounces-116559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB0A3805B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F677A3E36
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F8B217F54;
	Mon, 17 Feb 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqyYHqUb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238D23CE
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788662; cv=none; b=dBNe5lG/96GAyCukUbNd2viAVXWc7qDZ6paL+8XXUOdwhXoZNz7qT9FtUMFk52USM9McBc6Dqy89aXKWWT7Pkdae+Lkpf5Boq7s/wkvjIu9Yvzo5vu1cNdIeY2vcOWvX4ZKmfT9d0xdW7/Y6PLvz7ReqEAHnukvuFGocvUZV4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788662; c=relaxed/simple;
	bh=/bzErt8G8FR8t19khjbds1mKwjOt8namzpNBNSdxkO8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LT2DNuHbwd7SfCsudK0tNLQUhblOQ7Jtn75JtWMyRphPF1unBm5CBYYdAbFlVvX1sHgivKNXorXVS8ScTLx8jNREUrEFi6Re56qrhXl3sSWOd9vZTPokKbr/oEBqgAMOr9rzw6/TGgjk6wlbuFCSBffIuR6laK7SLO6p7EILoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqyYHqUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739788659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3QnuqXmgdzniJaLsLCeMzB55GWfy15gVerT6MR0b5Q=;
	b=RqyYHqUbq9fy825f1w3BKHZkx/wN5kbJt+GM8ont03t63Pjo4ZKnTS1i86UUxc4UUaZ32n
	lOPthM4PyrBG1Ro5VSwmvRVUS/2NnzmmkcrYU/ywkXclvvAAqhGcfBHCOvEc8iM9/alU2B
	5xu5bgCpaphuolZ2oSyYjhlMLDee1Mc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-a8Jdl3BLPTupGR9toQtJGA-1; Mon,
 17 Feb 2025 05:37:37 -0500
X-MC-Unique: a8Jdl3BLPTupGR9toQtJGA-1
X-Mimecast-MFC-AGG-ID: a8Jdl3BLPTupGR9toQtJGA_1739788656
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B4D21800873;
	Mon, 17 Feb 2025 10:37:36 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B885300018D;
	Mon, 17 Feb 2025 10:37:34 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:37:30 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
cc: dm-devel@lists.linux.dev, snitzer@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dm-integrity: Avoid divide by zero in table status
 in Inline mode
In-Reply-To: <20250216104210.572120-1-gmazyland@gmail.com>
Message-ID: <457c7061-2e0a-6a33-ab3c-3a69b7be47c5@redhat.com>
References: <20250216104210.572120-1-gmazyland@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Sun, 16 Feb 2025, Milan Broz wrote:

> In Inline mode, the journal is unused, and journal_sectors is zero.
> 
> Calculating the journal watermark requires dividing by journal_sectors,
> which should be done only if the journal is configured.
> 
> Otherwise, a simple table query (dmsetup table) can cause OOPS.
> 
> This bug did not show on some systems, perhaps only due to
> compiler optimization.
> 
> On my 32-bit testing machine, this reliably crashes with the following:
> 
>  : Oops: divide error: 0000 [#1] PREEMPT SMP
>  : CPU: 0 UID: 0 PID: 2450 Comm: dmsetup Not tainted 6.14.0-rc2+ #959
>  : EIP: dm_integrity_status+0x2f8/0xab0 [dm_integrity]
>  ...
> 
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
> Cc: stable@vger.kernel.org # 6.11+

Both patches applied, thanks.

Mikulas


