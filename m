Return-Path: <stable+bounces-6763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDF8139FE
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D2CB2135F
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F74CE1C;
	Thu, 14 Dec 2023 18:31:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8810F
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:31:08 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EF2A51C16A5;
	Thu, 14 Dec 2023 18:31:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id E82912D;
	Thu, 14 Dec 2023 18:31:02 +0000 (UTC)
Message-ID: <8f7d59b8945a2205ea7acf66da23d4673e48f166.camel@perches.com>
Subject: Re: [PATCH 5.10 1/2] checkpatch: add new exception to repeated word
 check
From: Joe Perches <joe@perches.com>
To: Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, Andy
 Whitcroft <apw@canonical.com>
Cc: kernel-team@android.com, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>, Aditya Srivastava
 <yashsri421@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 10:31:02 -0800
In-Reply-To: <20231214181505.2780546-2-cmllamas@google.com>
References: <20231214181505.2780546-1-cmllamas@google.com>
	 <20231214181505.2780546-2-cmllamas@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E82912D
X-Rspamd-Server: rspamout06
X-Stat-Signature: id891b4kedm3yaeg3wou4tc8j1iueqyj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+dCnfBdu8BaMqxvsYqUR2dakyt7deYh7Q=
X-HE-Tag: 1702578662-65474
X-HE-Meta: U2FsdGVkX1+Ngd24B9knn9sg56wCAoSXY3GrsDvl/NIscxJb6XHjCgtBUkcf9rcUkWBV8j7PmE+cVnMA918G/xXTb7VR2gauqL1q5Jr7qXRyxpdibwg+8Ry9GFYmTxKvwQI2oqEfFaIW/XNz7susOAf9SJ7f0z8piGIrTX8D7cRvNPEjedGm6zHv3/HZ6mq3JnmnUtIVCMC+MkJmPTCUyefLQd9NSWY88IxmqTVDx4DVNd+wbUxmDG3DMa8wqF/7gs3M2OcQ7lysgxZ9tLXexaJxIPp/JHLm8Er8vyD/y1hxQLgiLk3F8JqOcFi5QWdLrD4LhXCi9pNKopTjD7g1tZJ0GsqTVggg

On Thu, 2023-12-14 at 18:15 +0000, Carlos Llamas wrote:
> From: Dwaipayan Ray <dwaipayanray1@gmail.com>
>=20
> commit 1db81a682a2f2a664489c4e94f3b945f70a43a13 upstream.
>=20
> Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> moved the repeated word test to check for more file types. But after
> this, if checkpatch.pl is run on MAINTAINERS, it generates several
> new warnings of the type:
>=20
>   WARNING: Possible repeated word: 'git'

Why should this be backported?  Who cares?


