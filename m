Return-Path: <stable+bounces-253225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLNmNdQFDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-253225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E7597B30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94F7C32B44CB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E93FE34C;
	Wed, 20 May 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T91oALKn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jczKMYG9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006883FE359
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302725; cv=pass; b=XCmbznNSc3qm1+wLZob4qwMEnTgL+pw33I4Y2X9SaNhd0+weMN1emZ23MmUO0hWeM8eN5E82CYqPkn3FQb85mhvr5IvI0IRCAtNSp3nopZ9GQdqU9ALayg8zr2B7W3yYWl4SQdnF4qsFROlMoDpDX8dUOh41brfdiQdU4v+NvWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302725; c=relaxed/simple;
	bh=MBu9X2B8pymxnAWSnFXaGPij6bRewxrEGR1tIUkT9+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp0/zUqc2JZkJ45aDjzo0LwL2bQKiPwuuuiUWEHOv6AEjnVdFFDIIrjX4CVzmkzEmujQFIh7FRUi2eFoejAfKXma0XzyWkJuprpsftN+DQ0pPvXLj1BJvm8Io+PQrxHcLVAHYBErqYdIvWCUjYrEls4hrmdJF0WnsvuaemneUbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T91oALKn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jczKMYG9; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779302723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkQN7Jz3dmlcVLBByrLAHFF/AIIFafPxC3BLvbAjDyA=;
	b=T91oALKnKucS7BLpnxvi2SsWj0bcnV6mwhzHIUBcvY5Ux8zSxezj/vpgniHfKBI0DUzihk
	KlXfQ0x0ffaXm2XPkB4AbpHhPT5KtFn0gwMZDAjQ/mMW1eW1RGt+WEcy+g3fRe/QL/LAlx
	blB/vFoiQ93IlKt6e3G2HlErzv92TmI=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-w_n6oOQ6Pzm_Zb63Mp4Q2Q-1; Wed, 20 May 2026 14:45:21 -0400
X-MC-Unique: w_n6oOQ6Pzm_Zb63Mp4Q2Q-1
X-Mimecast-MFC-AGG-ID: w_n6oOQ6Pzm_Zb63Mp4Q2Q_1779302721
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6596b8ee4b4so11143813d50.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779302721; cv=none;
        d=google.com; s=arc-20240605;
        b=OSH1iq7xFU6s7hoGq60OXC3nS57c/y73vwp17BdMbtgU6V+kL1zG6C9SJ5x1mRWS6O
         JjEpJiafzf5I0CI8neqR7Ipl6120GVk5fEJu4V7HC9UB+L44mMdgVAbc8m4k8TUTwqel
         96t3ONMX9n2z2sbPfGsYWpkJyLVyfr7wcoFKbKqZpP9BHo+pN2ILg0e3bMs7us4eycli
         3PyBNNh5y8kt+PMO/4eGc/YP9UKgo3OW8n4wmeSvkcRah2hM73J50BVYFhe/4qbSt5VX
         BmL3GuINMEJ3GiSZP/bIhbWpEDOl/pK0zKOO0jmy9iuTZsFN7BQZ4Z1sXjGnvhx4XA2D
         U+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkQN7Jz3dmlcVLBByrLAHFF/AIIFafPxC3BLvbAjDyA=;
        fh=3o6tUOFzT0sMeQhoYapA6SAwFBAShlKZ02f6xyOA0hk=;
        b=Fwp/ug3lXp8jZJe4Rg0YRpS/Uc10vRaaXUSLTAILDklJbFIToZaukNISDyfTvkifC7
         l9cf+LvVwtan+8C4CmHzZa/V0IBCUOa6OH+rBYDkREa9144b1RHl7kRS4iJ68MV0Oky7
         BQaJMe9GW1K+lo7hAkQEXDZQgnAaeypjmgI3mR7p9nkoxH8NPoH5eUpbI7X14NAOXQyG
         7+PSbv6N8yNJdz7jIQtTGPxv1IaIgPUS7TSGAqw7s6wlI2rrBcI3+YcWr9IiZlOeji1j
         CMQHL8ifB6zTo3DwxSILw2WNSq3ta6750jpHWxQyt38m6gvSuY1RbNo6eTm+q3ntbR4c
         artg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779302721; x=1779907521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkQN7Jz3dmlcVLBByrLAHFF/AIIFafPxC3BLvbAjDyA=;
        b=jczKMYG90R8XPecHX54anj/EXy1QFYccaMuD5vJ0+q/PM4ARAJC9ugWQtpdSgD0TQA
         lJNeQPlchfluAhoYDvE8XENkOj24SUSgYEtLCItwnSqd/szaMKwmwliPwzqOzg1XjKxy
         zPUSkJ2wx8n+P/Acvdw566Zc0RHT/UljN86dzOdMdFG7atkArtLcfTTYipWt7mI99q9k
         l9uC5faHfZc2QxGw4aYgGI2Zr183sgBHdwfwnhooYoB+KRj7u9Vt8XEzixVM51Y4CsYx
         TMf6xR21er3mehgCb8kxxtTlKehjg9ZCTcKHF3NBel32Xtcma9n2MGpRES0L8IPR4wGs
         XE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302721; x=1779907521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkQN7Jz3dmlcVLBByrLAHFF/AIIFafPxC3BLvbAjDyA=;
        b=naIi8SESB4eoYOVKsZGJWVi4T9ob+EN0v+9fkwCgoH9k02sJq4QPP1skOoDDp4CYmx
         4hZviTwuIUoZ2wQVnIdMQZV5isFAUR0iMXR74dJ95O7+nQwHwqKWNM6Y+WR60/TWvKgp
         4Sl2Rv1ZMhwG+iCG24YeSDWDIWZ9nLIXnH4j/ORmd6ggyBI9VqLB0lfxJqt7T03NHqS/
         BWtwXal9Ksmid3CFeAQIQbwjXT1Oyqf315jQ60GKQGaoRdb2lH9aWa4r1Y5UbNO6BNEb
         WzncAVmPLnYFU4J+7W3A1ttO8RHIk3M+p3B7/iPxxPWhA+lyTaxSR1OLthrMG7zctaIv
         9Vow==
X-Gm-Message-State: AOJu0YxjVtjfzI9LZXNIV5tZtutajpuHZOXRrF6Lxl7ntaUMQI6LnGOj
	ASfVi6PrVjv9bz4ngmC9DPHu+VYqXTVjWlrz9aHz74H5NNGy8dPBUP/yQTs2KnvZU313qJ/PQtX
	JVC23EcuskhWnU+wbgpXkhjXcMdQebJ6EBobmOUL00MRIDLlj5FQ2mtbSQv8hxsXd3IJBDAfpLn
	awrR6T+LIu9Ju98/zZG7EcLalRd+1SxHAC
X-Gm-Gg: Acq92OF6ZYdYgDszRYXwX3B3jmlHA/MdgghK4fhln+sOpu4xKi7kj2L3nSas3/o1dtz
	8Jrk+Rr7G8jaw4e2D46953CzqSOO1mt17r/EjjyTd5FPtuGfoZsEogAs9axuIkAO5RAOgcc8ir9
	8TWyFZ4+NXkyqdXuzWVcxiIiLMr+zbqRDCYZSDcVxcWRX4mhBqIYAIQfN2rHiIy3QxhOE5mYrSv
	xB49A==
X-Received: by 2002:a05:690e:4191:b0:658:e840:d5b4 with SMTP id 956f58d0204a3-65e22751c15mr21641915d50.29.1779302720915;
        Wed, 20 May 2026 11:45:20 -0700 (PDT)
X-Received: by 2002:a05:690e:4191:b0:658:e840:d5b4 with SMTP id
 956f58d0204a3-65e22751c15mr21641898d50.29.1779302720454; Wed, 20 May 2026
 11:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162134.554764788@linuxfoundation.org> <20260520162142.034488466@linuxfoundation.org>
In-Reply-To: <20260520162142.034488466@linuxfoundation.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 20 May 2026 20:45:09 +0200
X-Gm-Features: AVHnY4Jc1nrTQbkUAir959qNNC65RhEgclffoM9HfcQTtbhYMpE5PAufxLoYQik
Message-ID: <CAOssrKcqmVW3kJ131tRF3LCJVQUtdRB31B5HENDfpgrq6r=jEA@mail.gmail.com>
Subject: Re: [PATCH 6.18 346/957] fuse: new work queue to periodically
 invalidate expired dentries
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Luis Henriques <luis@igalia.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253225-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mszeredi@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 876E7597B30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 7:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me kn=
ow.

This is not stable material, and I don't think the dependency is real.

Just need to resolve the trivial conflict when applying 5a6baf204610
("fuse: fix uninit-value in fuse_dentry_revalidate()")

Thanks,
Miklos


