Return-Path: <stable+bounces-238533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id knbSMSHY4mmc/AAAu9opvQ
	(envelope-from <stable+bounces-238533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5C41F8B9
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F145303BB30
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3819153BE9;
	Sat, 18 Apr 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEVcyCEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B140DFC8
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474142; cv=none; b=TlgZVZxhyNBbc4k4NB+qVkCmKHO979vED7Q3xsc4y+g7NEHtrm/wL/ImsC4fl+XOlVtsvXAmqssLEzou7v7AOYi2fUq7UjiWbqxVbbtn5Gb9FSd/UykYItAgX+RPHk48kmw9iJL8D5X1qFGx25qeb24R4u3aHSORF4Qo65YnDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474142; c=relaxed/simple;
	bh=uUvS7Jxeao3YBlEdpVMYKscfPq/CdIRsZMMaq4Dr3GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFLneoNSV6zz1TOhmKF4RBOFNleXpHLCIO73ruQxT4QceFNoYlTgZ//lkUA+CXcGM0UjUW1EBuneR7XNaJnV7DgCPzkGE/vRDYFNvHNuZHXiUbAQJcvPE2IW347nE4kdtN+f9u96spm+UUxP8uIR4aGGDiazHpdoXN+hZ2keRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEVcyCEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559E7C19425;
	Sat, 18 Apr 2026 01:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474142;
	bh=uUvS7Jxeao3YBlEdpVMYKscfPq/CdIRsZMMaq4Dr3GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEVcyCEJ5nexxHcYv07pXZTBRfAnRxtjXKXjhQprpreC9wTb/im3mxNwHB0hkskRc
	 +RQruNvucw7ZsoGfY48w3FHFBxB7fePGBYPT1kGOBt4XVwdcQMsZ+VZTURQ1ICEc3j
	 //DgVwH5gGvQ1lQBPk4sWuphoAac0Qu3lwW9f8z357DB2NLtnmb4thJTf1TrSvE7Nt
	 Wy6PZvilY4psud2QGkKEzP91Gdicq+Lv7n1bVxb4ql52FkwWwmi10wHnfRa5bPnay2
	 Y6/hSig33rOtWysE4VmBHDVlH3O0YVdkjWXSe2mxEAnYjK710AxE/7DAaoH3NYUJRR
	 RlmVObyna3JeQ==
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5.15 386/570] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Fri, 17 Apr 2026 21:02:20 -0400
Message-ID: <20260417190522.idxd-5.15-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <72718777-af7f-4d1a-902d-04e765a8e8aa@oracle.com>
References: <20260413155830.386096114@linuxfoundation.org> <20260413155844.937196566@linuxfoundation.org> <72718777-af7f-4d1a-902d-04e765a8e8aa@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238533-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47E5C41F8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> idxd_remove()
>    -> destroy_workqueue(idxd->wq)          // first destroy
>    -> put_device(idxd_confdev(idxd))
>        -> idxd_conf_device_release()
>            -> destroy_workqueue(idxd->wq) // second destroy

Makes sense. I'll drop it from 5.15. Thanks!

--
Thanks,
Sasha

