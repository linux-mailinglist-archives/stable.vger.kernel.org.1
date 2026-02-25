Return-Path: <stable+bounces-218029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPHWGZY+nmkrUQQAu9opvQ
	(envelope-from <stable+bounces-218029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:13:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4618E572
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD1063060BCB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574518DF80;
	Wed, 25 Feb 2026 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbi/yUto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840A3FCC;
	Wed, 25 Feb 2026 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978287; cv=none; b=bdsGQ0pk3ZBsAB8MLpFjIVg5HRoKVzz3mYo4wSjHYzIbXsZXZQWDiTGZVLvh8k+Quf9wdFYcZg1AT8HHmdnGoMnREVsMwdpMYnYVogiAmu2wiwy+Wnsj/DH6yNAjP/F5EA5lwaF7lpjYWh2b0a49y82X49htWESCL0u2io2AiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978287; c=relaxed/simple;
	bh=Eu/+E6Fe9CTf+32ncOdkyu0tZxs9mpbn4gaiq8dFxqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0aP4z1vVQrKFS4fMm1qzHtF97HHJSPoREpQCyPiCa4h7kRTxx52kSzXrLU2N96CSaaizfbmp+pvoWcvyk92wMcfLiRrYfrZclfszHgxoOxRcsH6DEzIeNtR0jbLLjdZV4TWHXbS15YncX8J6mKGDYkNnAj/WJchJqjey4pshGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbi/yUto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C0C116D0;
	Wed, 25 Feb 2026 00:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771978287;
	bh=Eu/+E6Fe9CTf+32ncOdkyu0tZxs9mpbn4gaiq8dFxqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbi/yUtoqADzlCBITKE11CFaiT9gHa2IQJaQhHBj1QC+6Wt2Qjk5Geuw94XAswPnu
	 VkNTgQaQoYnKdsGeCm3WEwDZDkTq5zeElAauS5dhoIMmHiyF5JHWUdTfM80fYjEClV
	 DHnsPzaCHBM8HBh5yXL6LcVO+DfE9r33ZR54RDBEOAsDN08T8Il9U8SpkaANG8oZZN
	 pJe6Mf4+tnK+oQyqMbMs1wFexYT97Et3D98VX/C4iOkLhGnjnA6gt0OsXa+RytVUus
	 CZzyyxuSi2c1rYLqn2/47SjD+KzY0LLWR5xujimd1Sx1k8X0gj/qHI9ZED9J2VuA++
	 slqj/wVFasEVw==
Date: Tue, 24 Feb 2026 16:11:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Simon Horman <horms@kernel.org>, <joshua.a.hay@intel.com>,
 <aaron.ma@canonical.com>, <przemyslaw.kitszel@intel.com>,
 <Samuel.salin@intel.com>, <jacob.e.keller@intel.com>,
 <pmenzel@molgen.mpg.de>, <sridhar.samudrala@intel.com>,
 <brett.creeley@amd.com>, <decot@google.com>, <david.m.ertman@intel.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <sreedevi.joshi@intel.com>,
 <rafal.romanowski@intel.com>, <en-wei.wu@canonical.com>,
 <dima.ruinskiy@intel.com>, <michal.kubiak@intel.com>, <tglx@kernel.org>,
 <pabeni@redhat.com>, <willemb@google.com>, <avigailx.dahan@intel.com>,
 <davem@davemloft.net>, <aleksandr.loktionov@intel.com>,
 <edumazet@google.com>, <piotr.kwapulinski@intel.com>,
 <sx.rinitha@intel.com>, <emil.s.tantilov@intel.com>, <brianvv@google.com>,
 <vitaly.lifshits@intel.com>, <jedrzej.jagielski@intel.com>,
 <stable@vger.kernel.org>, <richardcochran@gmail.com>, <joe@dama.to>,
 <mschmidt@redhat.com>, <boolli@google.com>
Subject: Re: [net,13/13] e1000e: correct TIMINCA on ADP/TGP systems with
 wrong XTAL frequency
Message-ID: <20260224161125.4dc744eb@kernel.org>
In-Reply-To: <842bb101-d73c-4470-a01e-f49f96847370@intel.com>
References: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
	<20260222162835.23954-1-horms@kernel.org>
	<842bb101-d73c-4470-a01e-f49f96847370@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218029-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,canonical.com,molgen.mpg.de,amd.com,google.com,lunn.ch,vger.kernel.org,lists.osuosl.org,redhat.com,davemloft.net,gmail.com,dama.to];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2D4618E572
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 14:59:36 -0800 Tony Nguyen wrote:
> Yea, looks like we need to do some adjustments here. Also, the AI review 
> I just ran on this is reporting another issue that we'll need to look 
> into. I'm going to drop this one from the series to not hold the others 
> up on this.

I'd sometimes apply series partially for y'all but FWIW the idpf
"defensive programming instead of proper rollback" patches really
don't make me want to interact with this series more than I have to.
You don't have to rework them. Just expect some delays, I guess.

