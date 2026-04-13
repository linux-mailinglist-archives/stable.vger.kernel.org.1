Return-Path: <stable+bounces-237672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VYPLEJZw3WlWeQkAu9opvQ
	(envelope-from <stable+bounces-237672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:39:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA03F3F65
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DF753039C55
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681B314D1F;
	Mon, 13 Apr 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRcQbB1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E631715F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119635; cv=none; b=eumAlikZInzbk0o6bQitZ24Ia9SZeT8o7AosA7uswrtmOFCvUefl6TJvPL0AajUeXpHT+SCl43oaHg6DrCbPVoSwJpyDmEVl9Rer38VocIlO7y+cG8d3amSdg6p6YOSmDRfZ9YHRUiU1LUKIgquZRvQoIzMkrbRZ3aykPNd2Vqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119635; c=relaxed/simple;
	bh=wlIZ9xAa436SleAO3b+EmYFXkc2yw1bnkLmzRqXT3tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViQvQhYQW9+D8dnwOWZgPSpuLAAtuUagJBlCtMS/9+IVAejbTlocQF+eMNVGtCxufkUBUF9cI8u6wCBznKEerDVzWlOtDgPF6Qz3MZUVJStyTFfFXRcxCYK6kb40wZoFSDXMIv9gcp47IyIrcboApWPx0U9XdiUkg4PXV3iWfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRcQbB1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECC0C2BCAF;
	Mon, 13 Apr 2026 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119634;
	bh=wlIZ9xAa436SleAO3b+EmYFXkc2yw1bnkLmzRqXT3tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRcQbB1SzCggTznl5Lb4HA462MeczidINtN8R4wvcB6jwTp4zKrwp5izvAjNWwwr9
	 AByHHf9lgOzER83OdaZrQURfyzWK7G1hByxKCRV/9EodIS4dWqHI+h+3zt5WfjB30H
	 Ybczh4DnOZrsqIUUOSDwzPTfpPjyi4+unrwKiYlADTV3zjw7sTuKyG08rcACYvrcyw
	 jmWaOZnuX/h7afvVsHqvCyC/w8vMC6i7b2fiaQmqKZBz2/x0E7UxiFgW8ppHo4wqQq
	 QSn+FJZcZ6Chje+wAD0VTa5xoLUgS3ToUe1hPDuDB4gBNpKatQlTZ5s3Hh1q0VZAtM
	 0IqKY/1atKlTg==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: Re: [PATCH 5.10 472/491] drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug
Date: Mon, 13 Apr 2026 18:33:52 -0400
Message-ID: <20260413223352.3761184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7fa93cd2c1f040e9fcd44b395c286a9c7129095.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155836.716796044@linuxfoundation.org> <f7fa93cd2c1f040e9fcd44b395c286a9c7129095.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237672-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85DA03F3F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-13 at 22:49 +0200, Ben Hutchings wrote:
> This has already been reverted upstream (commit 45ebe43ea00d), so please
> drop it from all queues.

Dropped from the 5.15 and 5.10 queues, thanks.

