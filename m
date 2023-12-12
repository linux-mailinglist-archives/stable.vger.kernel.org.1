Return-Path: <stable+bounces-6401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B976F80E3FA
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74694282DEA
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E156156D0;
	Tue, 12 Dec 2023 05:47:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1D99
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 21:47:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 167E068B05; Tue, 12 Dec 2023 06:47:07 +0100 (CET)
Date: Tue, 12 Dec 2023 06:47:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 06/55] block: introduce multi-page bvec helpers
Message-ID: <20231212054706.GA10922@lst.de>
References: <20231211182012.263036284@linuxfoundation.org> <20231211182012.465741504@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182012.465741504@linuxfoundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Uh-oh.  multi-page bvecs are bot a backportable feature.  And doing
a partial backport just askes for trouble.

So in this from: NAK

