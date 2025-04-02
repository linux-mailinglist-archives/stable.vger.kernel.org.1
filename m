Return-Path: <stable+bounces-127426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637BA793A1
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A000B3AC811
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05368186287;
	Wed,  2 Apr 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvm68viR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5832AEE9
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613855; cv=none; b=O0SAc8EiMBMr7Jly129Zv9QQboxXcitWMpOlB0MvqX4AurjgkdxMlQ3XB/qaDaYcBrHSYiw0e0qSQcCVhJQBuszUa9KXiQYscll9rEPf592EW1nhes6Mv7hjEsAYn48EaZlHwuIrFhrLFqAxveaVnZFnJrdsK0jq1oeuKZ14szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613855; c=relaxed/simple;
	bh=xEaasgmA8rD+DB8VhcWCdrDZeQhRBH1jjbOX1u8DirQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FvQzxzTviA6HySFJhBHkunQU2NcQdqiEMUip5cnY48lnEcrXNObiH/dqxLq2Vsv/gMsoJdrR9iltxK68XvARWBoyVFs4f/hg6MONh+4deHb1zbvyHBjUBnd+JhZk8qRF5R8JXuOxSonUoatq06JWv/x4viWJwJB9JpHAxVDQL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvm68viR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743613852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiTG0FByjC9Rs16rt52doAGprRUtZJNgSviOZz6x1o8=;
	b=bvm68viRUU1Hbn8LrzbBtkC051+f6GTM1WkFggKo0ScC+U+9QYuRUzRHNLA0a4Ql+5E7hp
	AEaVEX/ruMRBiN6AxNK37SoWDZn+mNZ1ap1XMw9N47wotFyzabmA9Uc3rtc33a39lZpPOE
	lMTUupLzN0fj9Er8NG64PICx3nFwwUQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-2p6AgTrvMp695wiKCVs6Iw-1; Wed,
 02 Apr 2025 13:10:48 -0400
X-MC-Unique: 2p6AgTrvMp695wiKCVs6Iw-1
X-Mimecast-MFC-AGG-ID: 2p6AgTrvMp695wiKCVs6Iw_1743613843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47E8E180AF52;
	Wed,  2 Apr 2025 17:10:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB43D195DF85;
	Wed,  2 Apr 2025 17:10:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250402150005.2309458-2-willy@infradead.org>
References: <20250402150005.2309458-2-willy@infradead.org> <20250402150005.2309458-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
    dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
    v9fs@lists.linux.dev
Subject: Re: [PATCH v2 1/9] 9p: Add a migrate_folio method
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <803464.1743613839.1@warthog.procyon.org.uk>
Date: Wed, 02 Apr 2025 18:10:39 +0100
Message-ID: <803465.1743613839@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The migration code used to be able to migrate dirty 9p folios by writing
> them back using writepage.  When the writepage method was removed,
> we neglected to add a migrate_folio method, which means that dirty 9p
> folios have been unmovable ever since.  This reduced our success at
> defragmenting memory on machines which use 9p heavily.
> 
> Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
> Cc: stable@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: v9fs@lists.linux.dev
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>


