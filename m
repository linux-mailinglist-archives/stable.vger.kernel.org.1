Return-Path: <stable+bounces-224647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQ/A1MZsWn6qgIAu9opvQ
	(envelope-from <stable+bounces-224647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:27:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BC25DC4C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2526C30900E6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864739934D;
	Wed, 11 Mar 2026 07:10:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE138D016;
	Wed, 11 Mar 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213054; cv=none; b=BYJ0eM2I5+6aK131/dg+uHD8vK/H5LTTRUf15lnNFt2TnSMqZdmL4vTuBECce/xx1k8XaAX2RGsD5H9DDNJCT8rVM+oSV9ZwRmVoVXJXheN8saIVflXU2xWus8AjCRbeDPfr41Q8iTitfYx84WQUU/d+c9C8d7mjorxBAWN0+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213054; c=relaxed/simple;
	bh=nG5QpDl0WwXxxEUbvogAjWfL4X9xBVWgNKIGnVanW5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pqWVdk65oZGxfL9ZZMbTpM6XAOqVNTe5z23vzLWmM5iBNydIn1cho1sVStt/Vv9v3ZJ3eLR9cPoQ9zLpMUZdn5aD3uIwlH6eTfeQlSld1rMFn5hh97we7iTZJvSiIkTri6GgIT7Ez5M6vDs7aNtY3LOou9crCSSlf63tQA8aEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4469EC4CEF7;
	Wed, 11 Mar 2026 07:10:53 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7A22B180696; Wed, 11 Mar 2026 08:10:45 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Tobias Schrammm <t.schramm@manjaro.org>, Sebastian Reichel <sre@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/10] workqueue / drivers: Add
 device-managed allocate workqueue
Message-Id: <177321304548.505649.413926339032568347.b4-ty@collabora.com>
Date: Wed, 11 Mar 2026 08:10:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6E4BC25DC4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224647-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.590];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:mid,collabora.com:email]
X-Rspamd-Action: no action


On Thu, 05 Mar 2026 22:45:39 +0100, Krzysztof Kozlowski wrote:
> Merging / Dependency
> ====================
> All further patches depend on the first one, thus this probably should
> go via one tree, e.g. power supply.  The first patch might be needed for
> other trees as well, e.g. if more drivers are discovered, so the best if
> it is on dedicated branch in case it has to be shared.
> 
> [...]

Applied, thanks!

[02/10] power: supply: cw2015: Free allocated workqueue
        commit: db254b0b232358ab1aeadebe8d147c99a3569559
[03/10] power: supply: max77705: Drop duplicated IRQ error message
        commit: 2064c64ceb1996ee02a6bbb1de05fd6e8028e3e4
[04/10] power: supply: max77705: Free allocated workqueue and fix removal order
        commit: 1e668baadefb16e81269dbfebf3ffc2672e3a3bb
[05/10] power: supply: mt6370: Simplify with devm_alloc_ordered_workqueue()
        commit: f23afa01040a41882a048e4957a7acac1426da6f
[06/10] power: supply: ipaq_micro: Simplify with devm
        commit: 2cfc7cac68e19c4acb236b8db6065bbaff5deee8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


