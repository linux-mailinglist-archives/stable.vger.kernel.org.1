Return-Path: <stable+bounces-223852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEmJO2nwr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A20249457
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 759693073AAE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF52372B3B;
	Tue, 10 Mar 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsGrawZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67936F40E;
	Tue, 10 Mar 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137864; cv=none; b=bDRBJGOois2H3TNm/jxbPLt1Ej+wxM1a0mzQ4wVBYKVhm+FphKoQrzewEDpbHT5/KmM9L0gl2iRUxl5Wb/fUmRqfdGC6qBLgaObUzKI/v/QzenTauCMn7o273qPodJkA9Srhuw8NXMc7ehcT+s7386uwYqryTvcl6LmFa2XVV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137864; c=relaxed/simple;
	bh=Qxw/VILjMxL5tYwGisG8wNcvLEzrIZL+mg/GMioXi5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaOFhdYxIun0E6nWGm01gvNTLaUYAcbVI7MkphR+LZ1XEy8GmpFDQvpVvoiXAyf2Uogl0gSTG+z52GqNHmSc+0hjHLSS2W2NdW04MYv+EvSsn8Jv2vZIsTp0sSqgBT647oQVrB9U7aViNT9MyxqWp9aOisCw93baPBveFddoxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsGrawZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADDCC19423;
	Tue, 10 Mar 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137864;
	bh=Qxw/VILjMxL5tYwGisG8wNcvLEzrIZL+mg/GMioXi5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsGrawZXNEdMQp+PaZuDU43zWRxHbjZ8j6fyiolG3EvTxY3PQSyWwM0w62zV9iLHq
	 k1P/46kZ7BTR61yQovXhshPxdztGJv00n/T9XbM3Ziyvy1TMfN+jB5fHKtUfOwcVM6
	 DVRRd3Wl7JfjXQJjGQ/j4Aa4q7LSH+TvZg81ckMYk8hAcIzAk6i+QsjlrGDTK9IMY9
	 NtbAW5w9dkgQKzEfJHyZxmKFG0lC3Ybb6/0GyEHhVzsg6bx0NaHEgd2L7BVlUFcwy2
	 pzTHWdWo/TrJ0i4LyxTabPS9KMsMUY97/h84+qNLVofeY2kawD96kic6GFe16Mo0i0
	 nd7Rh/QmF03xg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vzu9m-00000000NyC-04GK;
	Tue, 10 Mar 2026 10:17:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug
Date: Tue, 10 Mar 2026 10:17:39 +0000
Message-ID: <177313784323.3940002.13678040844049570488.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310085433.3936742-1-maz@kernel.org>
References: <20260310085433.3936742-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, will@kernel.org, catalin.marinas@arm.com, qperret@google.com, tabba@google.com, vdonnefort@google.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Queue-Id: 75A20249457
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-223852-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 08:54:33 +0000, Marc Zyngier wrote:
> Hotplugging a CPU off and back on fails with pKVM, as we try to
> probe for ICH_VTR_EL2.TDS. In a non-VHE setup, this is achieved
> by using an EL2 stub helper. However, the stubs are out of reach
> once pKVM has deprivileged the kernel. The CPU never boots.
> 
> Since pKVM doesn't allow late onlining of CPUs, we can detect
> that protected mode is enforced early on, and return the current
> state of the capability.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug
      commit: a79f7b4aeb8e7562cd6dbf9c223e2c2a04b1a85f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



