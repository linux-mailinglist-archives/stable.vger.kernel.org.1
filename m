Return-Path: <stable+bounces-253529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOr2Ex4JD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:31:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9B5A5CFE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 102E73339895
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED63D7D74;
	Thu, 21 May 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4YEdDj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B43D7D90;
	Thu, 21 May 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368169; cv=none; b=kgzW2syWK8jVYznmRRFuxll49mYHvpInIQVh0iQqHAPRJ/n8seeQ1HsQqVHZvDj7xMdRkeqsv1IaR+ldqh1YxNGJf+c6L4UQz9JcQKGIb13QxoQuKlMBQH8EngLAylXWembYM89NUyxTnglDqiAgG22WCxpdFSOVO5BhSg3BuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368169; c=relaxed/simple;
	bh=uwcRtwudW2FP2P8V2rDDPMnj5TADNxBpDd5s5gso0ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIN2awbptoRFH1CwFCo1RkQAGhACYSK/6l1bkldO2c4NX+wXE182z0yihBb8Wen3qA4DkExL+xiiqrkSMInfT7CJSs1D9DfeT1rajBuerBwluwlWL9XWo9dMr7mtu0L8v/sRnI49KCgdITu4AjRVEH/I5nxJoSQJ/RCmzmKTJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4YEdDj+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE5C1F00A3E;
	Thu, 21 May 2026 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368168;
	bh=uwcRtwudW2FP2P8V2rDDPMnj5TADNxBpDd5s5gso0ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4YEdDj+zMPVkDT61xcCSbzVYEVV78OJ/q9yDxFciI1msrvmDBo3BaQ8DT5irg3o2
	 c0ZA1c4mLG7Q6xQUaYkrvk1eEpKzCnDxa/jNHfybrQznQFbzPgW6kzmRrfrOVYPuCs
	 5qMGlcswxw61EAbasv0be0t3jfrTvbCUBpA2fjQGlIVDtFq3+9LNYlllGXSUAeP1V1
	 gWNoPIznVhsWqmvziRZMlPyjPYGXSxlnyvUIIF0M5ZESigVdrlpY5xLwAE+nCuxyCJ
	 euLLoJdIGtGZAV+HMjHa97gb6JQ8/FCihJfuaiTLbs37WEp80nTznMsY3yzsl5pSOh
	 lHBmbh7c2PJJg==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH 6.18 052/957] sched: Make class_schedulers avoid pushing current, and get rid of proxy_tag_curr()
Date: Thu, 21 May 2026 08:55:53 -0400
Message-ID: <20260521-sched-proxy-6.18-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANDhNCpZWMk6GWubK8+E0rxKUqtuhOtrjqxunS=Kmho-UbR0UA@mail.gmail.com>
References: <20260520162134.554764788@linuxfoundation.org> <20260520162135.687777470@linuxfoundation.org> <CANDhNCpZWMk6GWubK8+E0rxKUqtuhOtrjqxunS=Kmho-UbR0UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253529-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCA9B5A5CFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:32:26AM -0700, John Stultz wrote:
> Eh, I'm not sure of the urgency of this going back to 6.18-stable, and
> I'm not sure its worth the churn.
> [...]
> So I'm just not sure this is worth the churn/risk.

Dropped from the 6.18 queue.

Note we have it queued for 7.0 as well; since your note here only
named 6.18 I'm leaving 7.0 alone for now -- shout if you'd like that
dropped too.

Thanks.

--
Thanks,
Sasha

