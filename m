Return-Path: <stable+bounces-5188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202D80B92A
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 06:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73391B20A63
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 05:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D59187F;
	Sun, 10 Dec 2023 05:47:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EA114
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 21:47:34 -0800 (PST)
Message-ID: <57ec0f7a-0880-47cf-aa7c-03fe5b8b2356@hardfalcon.net>
Date: Sun, 10 Dec 2023 06:47:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6 205/530] af_unix: fix use-after-free in
 unix_stream_read_actor()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Rao Shoaib <rao.shoaib@oracle.com>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>,
 syzbot+7a2d546fa43e49315ed3@syzkaller.appspotmail.com
References: <20231124172028.107505484@linuxfoundation.org>
 <20231124172034.306582342@linuxfoundation.org>
 <6db03eba-abd3-41ff-a2af-9fca0ca24c31@hardfalcon.net>
 <2fbf23b8-8046-4f10-abf8-294bbe261c5d@hardfalcon.net>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <2fbf23b8-8046-4f10-abf8-294bbe261c5d@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Update: Kernel 6.6.5 seems to have fixed all crashes and other issues 
that I've experienced with kernels 6.6.3 and 6.6.4.


Regards
Pascal

