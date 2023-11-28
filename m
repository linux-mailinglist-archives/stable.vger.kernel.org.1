Return-Path: <stable+bounces-3077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76AA7FC824
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EAC1C20F6E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEF44C94;
	Tue, 28 Nov 2023 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819894;
	Tue, 28 Nov 2023 13:42:44 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: dan@danm.net
Cc: linux-kernel@vger.kernel.org,stable@vger.kernel.org,toralf.foerster@gmx.de,linux-hardening@vger.kernel.org
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference,
 address: 0000000000000020
In-Reply-To: <20231128213018.6896-1-dan@danm.net>
Date: Tue, 28 Nov 2023 21:42:03 +0000
Organization: Gentoo
Message-ID: <87jzq1lflc.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I suspect this is https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
and the patch at
https://lore.kernel.org/linux-hardening/170117162434.28731.12930304842635897908.git-patchwork-notify@kernel.org/T/#t
may help.

