Return-Path: <stable+bounces-227806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPCHCohRv2lU2AMAu9opvQ
	(envelope-from <stable+bounces-227806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:18:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7292E7F8C
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E392A301651F
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEAD37CD40;
	Sun, 22 Mar 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rpN6N19m"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1E37C90D
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145740; cv=none; b=AXP2O50hYzBfiK9E0wjE08hIEadyn+H7BDQbwMV6X84k9MIT9XAzoJlKFjxoogzczVz6BGMZ/0qtGEd4w2liXZg5pHiwRtuWnn9/MtPAyObfnTyrDQyRfQEiHcM9a7KD0WsTpG8TKqwYGwkGxT5iTCCRoNrh5YeE7JHdqc2d7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145740; c=relaxed/simple;
	bh=/CO5DI1+vjZJpsR19ThTPqJUwt4jMlly9UXWUi+vZcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD76Bq1uqWGTnzIoSMLjG+ylAch1WJ8iMtJLoHMmtmyzRTtV+vU0qrlUUbiIqlRmF3BOiGi9tzZA70kS1iYwbhBdjHZ4hYJJRfoGc27dGvaP3P8Pmy72qBP2uBCuurubQ0JW/KCMOM/Dl6l4onN4o2kzGjTm2iKBzh7eNniHig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rpN6N19m; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b351eaf81so16408881cf.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774145738; x=1774750538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73dV9HXBKalzANZz6e9BQWQca8l8F63yfgi5tVHwkR0=;
        b=rpN6N19m0zIVfgQAVmErc2bqjy+FDYxnAki7kRrnyavQUfyFPe4efPv9Y8NjlGYENC
         LTLPhnwr4dGcuLbJAx/n4wMnii4iUCcJVrfHltCF1nEkez6otzTxmyuV2BYosqw1iaVQ
         rEdHs7ff5/BiAwIsX0/74mWM01cq4JFqOFTpBHFBYbNbwZo8Q5kBNK9lf1gOE5UKefEi
         MzvUC3ZO9kFycNe/f2X0roz4KCACK8jzMifUILQbpdz1zCfw2Nr7yeRqnETDP4JGEiit
         ydLiOK7xLQFiHxazwi9+/H9fa2W/pZpsFvZJIp64frmLK1+lZ5QgPY8CuhUHalfy7xLA
         PATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774145738; x=1774750538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73dV9HXBKalzANZz6e9BQWQca8l8F63yfgi5tVHwkR0=;
        b=FoazcRvouDntaToOQIKKAm3hkHxo8heR9pSs1B6a8JvVyq5GRaH8EaETXlrl+/Y8jc
         r2hwEg9vV4OcFiZVyoElXng14Oez6uCR2+8m7E8+LVRNLelRNXYATb4x2PnPS+pFGwxz
         o8dbgO4iDOgl/VeLfDA+ihg5PaYtw7ILFdiYybW+3tPZao6gTB+9CFiDxp/syw6EaEnF
         1rZOn9evJEjXz0S97V+6GvTY6pN/Xb/CabZFoBoV32r+v/G8mVDYZcpIrvDsbtEuVhOr
         hkQtVsohOiW39peoiiplFhi9BSOTw1RRTcF6KuG2L9/WyCSqjzsurX77LdViIu//Bp8y
         sFzw==
X-Forwarded-Encrypted: i=1; AJvYcCWr45THHFrpWMTpd9VmSP4PGFG35OIzd9HoFjsQdBcHgzgnCTpzZ0lP++DzxYRd44VfI7s0lRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIME1fZqK3PoGokTgBEHmovV9TDVAsJfE1Y6OonDbo3Gch6tiN
	5w2lMfbafEY6ZpXfMYkhIuf6aM3GH2eV5CCNKr6wpfEzLTLQHwoMrU6vx+Ow3EOs7g==
X-Gm-Gg: ATEYQzz+vbCvEoMQ/HgJ0ud/3irBQ4ImH8tllcRPAjZxU4kn0teOLeEyhcD2gL9QdZK
	rEB0uToNG9/eVzfkkDWlOrKtdvHqaPitf/yirxJiBF+1JNaCfk2QpYtCDwuT6vY4znB+xcqFmrJ
	cf0Ptf8piHFqFH+KvWhyjv5JqPdGH1pyTpor6h+wvYpd+wH92ylpHXVSBoFBlPGKg+OuJZzLwQA
	bxnJ/Z5QOVZGV+jz2PVl/JvoWy3mLHm2lsA26DTgpq2r/sYOffDQDfFcCBG50Jz6N/5YtrdOsAU
	1Z2NURXA13sCse/sTjmO5we+i/KyAmbQI3O5/TjCdqfbnx7MwuDJRn3wa6Y0H9tZqNFqgk3kmwH
	LAhXRmCVsdq8mdCNKbD8oxBCLJ6vhdRe6aJCN3mPqN39bWOUZJmk+Q9dlJoSDn/nzBQ4ZMURfBy
	B0bdM2hcyCElKlXRrCnTL3Geo=
X-Received: by 2002:a05:622a:514b:b0:50b:506d:7381 with SMTP id d75a77b69052e-50b506d84b3mr35971741cf.57.1774145737659;
        Sat, 21 Mar 2026 19:15:37 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::b00])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e810fcsm52599431cf.24.2026.03.21.19.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 19:15:36 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:15:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: JP Hein <jp@jphein.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] USB/UVC: Add quirks to prevent Razer Kiyo Pro xHCI
 cascade failure
Message-ID: <8877c0e6-232b-4f17-818d-b68151c1b9dd@rowland.harvard.edu>
References: <20260321223713.1219297-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321223713.1219297-1-jp@jphein.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227806-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C7292E7F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 03:37:02PM -0700, JP Hein wrote:
> The Razer Kiyo Pro (1532:0e05) is a USB 3.0 webcam whose firmware has a
> well-documented failure mode that cascades into complete xHCI host
> controller death, disconnecting every USB device on the bus — including
> keyboards and mice, requiring a hard reboot.
> 
> The device has two crash triggers:
> 
>   1. LPM/autosuspend resume: Device enters LPM or autosuspend, fails to
>      reinitialize on resume, producing EPIPE (-32) on UVC SET_CUR. The
>      stalled endpoint triggers an xHCI stop-endpoint timeout, and the
>      kernel declares the host controller dead.

Shouldn't a fix for this be added to xhci-hcd?  A funky device shouldn't 
be allowed to crash an entire USB bus.

Alan Stern

