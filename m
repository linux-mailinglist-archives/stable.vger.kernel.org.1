Return-Path: <stable+bounces-230024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL9bAee/wWlSWAQAu9opvQ
	(envelope-from <stable+bounces-230024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44E2FE48D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8C830530F9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B9379991;
	Mon, 23 Mar 2026 22:32:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F135AC2D
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305140; cv=none; b=kfep49ba9XQ0A1tJgAIbzM1dcWiX+qrT1bzvLMhO+t8o8Ol4osPW0dN0RAU0N/ZTG+dKA0pm+aau8PdEHkLyimDgtb7klqzg8XsTUoFtQh2AbyopWMB3FCjWSrLj5CrOFXwLvASI8PLad+mUu1aNp3SWFso0MqjZL9EI+DX2Yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305140; c=relaxed/simple;
	bh=W2MikfPMLo8P0OJj5ewC+LotKWTg8jOhnz+x5hUrhVo=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc; b=MgprZiWcttWEYBnO8ZFtwUWCJF3yGhEvtDJT4xcQeMtZ153IRtzkvph2p73L2sFaQzhxXjC923IYejj3Z4QerJbCneOkx64c8poeHGieQm9ys9ZRSpARz4/mbpRy9cupo6M53d50YUJfjoQBBGNHFDhKoXBfCDUeajWGfzQrEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elrepo.org; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elrepo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1w4njq-0005d1-JH
	for stable@vger.kernel.org; Mon, 23 Mar 2026 23:27:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: Akemi Yagi <toracat@elrepo.org>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Date: Mon, 23 Mar 2026 22:27:05 -0000 (UTC)
Message-ID: <10psenp$dtr$1@ciao.gmane.io>
References: <20260320172335.29778-1-john@kernel.doghat.io>
	<o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
	<fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>
	<ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.149 (Bellevue; 4c157ba git@gitlab.gnome.org:GNOME/pan.git)
Cc: linux-pci@vger.kernel.org
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ciao.gmane.io:mid];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[elrepo.org];
	RCPT_COUNT_TWO(0.00)[2];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[toracat@elrepo.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-230024-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8C44E2FE48D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 20:43:55 +0530, Manivannan Sadhasivam wrote:

>> Dropping this from 6.12.y and earlier stable branches seems like the
>> correct action to me (but not a mainline revert, obviously). ACS had
>> essentially *never* worked properly on OF platforms prior to 6.15, but
>> that was more down to fundamental design flaws in the OF-based IOMMU
>> probe path (dating back to 4.12) rather than any easily-fixable bug as
>> such, so realistically I think we just leave it that way.
>> 
> That's my opinion as well. I guess I need to send reverts for rest of
> the older stable kernels as well.

This is a short note to say that the 6.1 kernel was affected and the 
issue was fixed by reverting the referenced commit ( https://elrepo.org/
bugs/view.php?id=1587 ).

Relevant bugzilla entry is here:

https://bugzilla.kernel.org/show_bug.cgi?id=221234

Akemi


