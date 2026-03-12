Return-Path: <stable+bounces-224859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCNkIra5smmvPAAAu9opvQ
	(envelope-from <stable+bounces-224859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:03:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EE272359
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43EAA3019FFC
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE93C5528;
	Thu, 12 Mar 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/lZCdRk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491A52F8B;
	Thu, 12 Mar 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320614; cv=none; b=CbvKNeE2xjJgbmkqo0xIGvSmN7/KW0cNIksFzqq6w997Nb4xEnL5U5lNSi54D4DvTeR9xDIqNECBy5W/QvvaSd8atF0VGExt+iG4VpFoVkVad0mW1+rUrZGyq0xlOb8MwWIoIT5QXJfxG2P54w7OlT+oWDF0j7EwqKIP7AxTfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320614; c=relaxed/simple;
	bh=G/GvL49Z4wjmBDZ0WLQju4xrr5nQMe5GTTgsCS9txOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=opmk9SAKDIwGot0Jt3s1TjuNo3f3igXyOGntcFjWyNJLMN8nMl+gZhdi/hrjhykStB6PkWkTl3wSUrokHSqWEQs389Yz+6cQIzLxvC5GCjjPB7rLLG9OLLtfdg2NobZzF9C5B8t+5q9vdnOg08miLaTFAjnQ+etZ11e5qSeZq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/lZCdRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CFC4CEF7;
	Thu, 12 Mar 2026 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320614;
	bh=G/GvL49Z4wjmBDZ0WLQju4xrr5nQMe5GTTgsCS9txOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M/lZCdRk4LUk4OXpeYyXZ71PPnscUaHz9LdHooQxPDhW39JsRELHIS4OgbAKxUuxH
	 iYQpHsR0NP/8ygsagz+j3hq5f6YYqnjF2YI3mXPIJ067uRghhSIMIi1VApV2/m/tu6
	 cc5/gWfEv1qv25knQH/65ydMnsWDK6JZygpBcjhRz1aovmMuiVdfl6xZnbE5DxDBBi
	 tzB7JN0tMyJz+bLX3WudQ64om3Xo/bVi9tVCo2t/BwGbM1eftYG4IcKySyHGyvOpSY
	 mn12SHehBTPyG1O+/4kC643Gq+1a5KNUy+u0ykkp+iXWXtnbp3fn+sC3ZKxPsc/m2s
	 gPsasc7cJh1Hw==
Date: Thu, 12 Mar 2026 14:03:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: appletb-kbd: add .resume method in PM
In-Reply-To: <MAUPR01MB115468D46765D7DF8C2882B4CB86CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <qn346258-8p42-38r5-86r8-8n1r87204319@xreary.bet>
References: <MAUPR01MB115468D46765D7DF8C2882B4CB86CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[live.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224859-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,live.com:email,xreary.bet:mid]
X-Rspamd-Queue-Id: 311EE272359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Feb 2026, Aditya Garg wrote:

> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending. It is the same as the reset_resume method.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Now in hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs


