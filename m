Return-Path: <stable+bounces-247208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGbBM/NBWpGbgIAu9opvQ
	(envelope-from <stable+bounces-247208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:27:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D47542537
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD17B30684F7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D23C872B;
	Thu, 14 May 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da6DLylU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGxktUxt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E525E469
	for <stable@vger.kernel.org>; Thu, 14 May 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765138; cv=none; b=vCPvAAv+TPjn9V7qJyE5nw8fawtgioBdQFrPjOctccouiA9XOf2SgpPb1rupB65KV++go87zQ89slsc4pXKcCfbxrQWjr0Jcfe0osMRxWTB6PXYVA7RBz40TIQ/DQdyeLefldGQOq5FgIF+gIwRCcxcrVI4Uj8Ix5Ra6MzH8d30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765138; c=relaxed/simple;
	bh=uak09I5G7o+Uta6zeHmkGlTeC/61IsikBhEoWswRQIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EA4mqdXIYLc0LBs2XSc4GIkMsarlZ3ShxR9XEtp4A7I1qThrsybQtMs4Xh4BS+x/B+2TaXZxkenJ6Ri3cw5JhAljxRqi40oeOc+jI9oBMq4nyS1WRf+f7ZAjuofL7E9MddASlbYb4DeJmcHneNFRDHqnlytVCIDsq/Odvjgot5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da6DLylU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGxktUxt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778765136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1O1Ei0k1E4z4CykvBcqK2Y97KyRi9nODszSe9zh+1m0=;
	b=Da6DLylU5gCBLx6WcIq9XuY/kGS3iygf3J2aSbCDNxVo5zG+i6P0UUA0zGiV/C4CTap85t
	37DFvI42qbHXUGhjXyA+xYTUIbcsQwxMBLw9+kLlSuUOtOGBJpo3VanqSnd3uPH006oPCp
	Hj9oXc9mOnzXnfr0rjV7T7wyhTuwIV0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-vfVVOMzVNJiZzxuDJ5-pHA-1; Thu, 14 May 2026 09:25:34 -0400
X-MC-Unique: vfVVOMzVNJiZzxuDJ5-pHA-1
X-Mimecast-MFC-AGG-ID: vfVVOMzVNJiZzxuDJ5-pHA_1778765134
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aca14d1faaso239879596d6.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778765134; x=1779369934; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1O1Ei0k1E4z4CykvBcqK2Y97KyRi9nODszSe9zh+1m0=;
        b=bGxktUxtDtIQyx3qqBHb1R1eEq7cmpsGsQXFxrFyeiC+RNKB3iWXF/fk2Nv2UiXdxR
         w7VAgfMiW1X6REt6aou+CL+xW0pSpdGssHM56FFtR24yLCJ1bMGuE1snjHER0Q0cB5Py
         fOOPp0ZUXAzyb8wxD1SQfxDAqbYWaEL6woUcglxju7SBlSwBCy9NmP1Szxop96mp9tzD
         UDZNchUk+WsIt7mfa3GyYGSeqhEMahLqf/DGpvKEnaH+zWLk66/aiphLr/wa0qL0XqH9
         btF18nqzJhtTg9AomYp1HQZXvxKNWXONVh+5dAV2tR9Kjlxt4A7YZpPN3RbVMSjRZmzy
         93yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765134; x=1779369934;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O1Ei0k1E4z4CykvBcqK2Y97KyRi9nODszSe9zh+1m0=;
        b=St2iFMdA4Y2M99EjI5MumzDIFE7lBdlEaezpiOmbwDo6aDUOynCBs0WL/nvDtah9/o
         5YYQQLFCMJQG9V9fBwMzC+l28iBFoKTUQdCVjjQVEZW0/PXSBT6u6G+ZrQ+T+BcmevBO
         8m83eHBlynG5XV4Iud13pTBpfiT/Drpu9Ym8m+NhvlB6SX2IVz8BFRJ7mAixTjzNDhZb
         ZeMdCXlMuM7OwPrQZhtgQQwaWVR4Xed3642z61APO03CGFKcnztwsZHL5+duvFH+rTwD
         /52VMF08k1DIBfrfPW4qPFBMvmk3192ZNStGPa3UyONSXErmwZvfcyMbyA1V4iwYYZaf
         7pBA==
X-Gm-Message-State: AOJu0YyaFJIIUhIem4rLbvdXCRV1L/iF/RrD/MxCawJjqsF0piL173Ix
	WTzWJj+NStH3uwVUyBLVEYSoHnBhwGxKDU9vMj1JF4PwmpEEIYXC9iQCfhRxrshCM6yNqqyDlZw
	zCXw0eB323+IDcHzxRpkMZ1N1Cguv4MutfrTsnmj5n1Bv+G9NLXpeHFwO8EDo40X8PUISLwXY8o
	FDqMGKtQid95oL7OdnP15LXxifosToMid2/LNJQF+3+g==
X-Gm-Gg: Acq92OHTsJ5uBMnKHXTPjhJWeUN5QZELaWVOEXxl8CmCoyDB+Jt2rqVX9cOUveRRIU4
	r5LmOaO+QXgh2jmb/xQByR2H7vaLzhT+B8uOpAUQR0fn8oE4wJGTjkXf9CtIOg47ohMsaAnwGwi
	SAyL5TLhA4mE4TTuW6jG6KqkSOWyq8gSU+D6hCB7OZPv8ZaZpA/JQ45N69Tzl/QhjPQ2vJp02LW
	pGKz2zrTsX28a/m5zeuSHBIkDpQuUSrMAWtuG9d1T6r28aaOKRFOIbBiJBlFlIBi+9RH0gDaLpM
	L8ADKxUe6Kp4q5huUj3lj1FtIxlRJSoKVSrvKWeE7bZDbSZKrksl6+mLhvn+U6uPz0mpX1GTopA
	z169hX6dPrciQSjulGU1pRVi7s6XB7YSawaqoRk/Cq+H+Ow1i4JossmCSJBo=
X-Received: by 2002:a05:6214:3117:b0:8b6:7f3f:5286 with SMTP id 6a1803df08f44-8c7bb3ba30cmr120499036d6.20.1778765133955;
        Thu, 14 May 2026 06:25:33 -0700 (PDT)
X-Received: by 2002:a05:6214:3117:b0:8b6:7f3f:5286 with SMTP id 6a1803df08f44-8c7bb3ba30cmr120498556d6.20.1778765133465;
        Thu, 14 May 2026 06:25:33 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b3d0c80sm22735666d6.31.2026.05.14.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:25:32 -0700 (PDT)
Date: Thu, 14 May 2026 15:25:29 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating
 bytes to copy
Message-ID: <agXKLQjMytKNo3kZ@leonardi-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Rspamd-Queue-Id: B8D47542537
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi stable maintainers,

I'd like to ask you to include the following patch to stable:

080f22f5d30233faf3d83be3098f35b8be9b7a00 
("vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy")

This fixes a bug in virtio-vsock, that leads to an EFAULT when the user
performs a partial recv followed by a peek that requests more bytes than
are available.

Please apply it to
- 6.12.y
- 6.18.y

7.0.y already has it.

Luigi


