Return-Path: <stable+bounces-208360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D87D1F14A
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EAEC3015857
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B239C624;
	Wed, 14 Jan 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awJ9sA5/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71F396B8D
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397742; cv=none; b=pMrlXpltG5oksUs30tuPX82ncbVsDz7exzVRkeusVjcSbgxSw+a1MvtVYawFEIyCaIwqaUtBKDUx7oYRgjPbXHJQpjVJbYW8GJNcXLJ6FwSAeTrgGyQNDu7Y6L5PoSb2NdBLOK4Y1Cm58Ydfv8fJnZI+awsbaW6GcsWICvegsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397742; c=relaxed/simple;
	bh=FVAFxCkrY1hqsXCRQh6iZOM5/9mEdba4kTmLBXhSTkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vCe3Rfsn5aqMW1Zg6M/3E3pbWSSLlXLCyO05Y6O4rymdqV8jhQyu0PF2PKS0l2IJGf+YrcSzQh5cJYamn7D98Gl83TSIXz8WdQOTKSLZjSSPLNHnDX2gXeX3v5twpln4NMIwg12N4l81MskQNgzH63uNZypxDgjU8+9pUcT7bOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awJ9sA5/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso18395857a12.1
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 05:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768397739; x=1769002539; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k0CyQGmKP3Ppw+v/hzxqpF6zshGAi4PN54YlP/hI/iM=;
        b=awJ9sA5/QlyLbmZKvXxAvpJ4BU9i6Ancz6y8+qEtWpGfkwpgGz4Ng+xAj1zkna7HDO
         Xj4eiedF39jnX4/8xmW8HGclOJEU/gN5RSbdI3BDllEOFsiUcxP3k/pa3qeV5vZ/GWfN
         O3nfpV8FmKuFp5Q3sC0hPg6DW1FhRFQWvJOYwr6YtYBNioCdpV/kib6Mb5wwFmb8bYp5
         0kDoQPqe0Wh/DUA7Vsl/sc0lKdeIakxDsdGKxzCVU7CTOwC10oEqT9qN3y52VzH1FZTz
         kvHZwLj4MnJZl9aiJ3LhvTG+eHx/humpPeRYx8BzlisWnXHcbOy6Z0aIoytGY4zMUmkG
         POsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397739; x=1769002539;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0CyQGmKP3Ppw+v/hzxqpF6zshGAi4PN54YlP/hI/iM=;
        b=SkIsjIJPIBYr+FuTWDwIUsUVTOjSkAHTtFDx6rh8sqe33oJNYdTZboHs9bI9pry/Gb
         okWFlORxxdVrftOIydIcC5pawjJCsDPz2itJt4kOm9LI7qIXUkzw/noEXBRboVjXl5jP
         lXgfMCxzXaBGJadlCCRWqi/pGy6kBaMnr91vHgIp7U6Yk71zxquYIWwLgMQyPD43htwX
         xZ8dakONZjGwFrzBv5tXvPL+E79c57lq5NfdS6SIKFzjVGlP4cN7z1z4Sbxnq1JE4/GD
         tiE5jbkePbLkjhVOTuFzwFiddOdtzmZ39oBShsTSur607osp9dm5pJUvTzfF590yW+wl
         IZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVuP8KkO4A5Hn4YghQvglaEeUCWKKjBd5FZrLISfsyvpzbD3pGgh0JoW5grHscQw8LYmRM+QE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytxkviaArZSS4yDh4hUjL4HZ4k9d/jA8VCYpmhimDJE607lWjB
	mjW75HZq0pfCc5gNIjSMjEmXAzsShkyv2Zv7U8BPrcRHp5fQosKNfzQunuj/hzK2b14=
X-Gm-Gg: AY/fxX6ZcwR+vIR3J/XUztXvCHWMhrPAF9r+VCI1w1z3xYAZt8xJZ61Cp7EjdGIPAky
	gbdWqxNOiKxq5yORvY0Co275KLR5ldaJTtbON4cp61pd4RMIVUz9rKVht3QMS5zN1yr49EyC86T
	dNHDO9rdk8jCeZphSKor3qloOazJV7vyeFBB6xL0Dy1ArgG+UiH281vQmNxKJREW5eL/c31MmGZ
	loCweqdEJzkEbmZxWCBYYiCxs7prjCH9rlnbpywjTuA9RSxdoAO18ltum0TrajOnQTl3MED1GLE
	l2WNyuZ9KGW44QQxP4Lu+qG+9BfyJzQLoT3N+7qvciOx81D0u2l6uerow2YlY5PtMyLjfXjfcna
	I9jDa/pPl0wT2VJDW0xRn+N23I3gpVGxDx3l9OO1Q3Rv6/yXFfr2v1yKJE8dBOfF/1NgtBi9k46
	xuPLHdScTcdYTRp4cGWIAhRwD6XcQSf5okZxI5jM12lYNVngRPhdWUeXk=
X-Received: by 2002:a05:6000:2511:b0:431:5ca:c1b0 with SMTP id ffacd0b85a97d-4342c4f2b7amr2408511f8f.4.1768391267620;
        Wed, 14 Jan 2026 03:47:47 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e175csm49090275f8f.14.2026.01.14.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:47:46 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 03EC7BE2EE7; Wed, 14 Jan 2026 12:47:45 +0100 (CET)
Date: Wed, 14 Jan 2026 12:47:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	1120831@bugs.debian.org, snow.wolf.29@proton.me,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: [regression] failed command: READ FPDMA QUEUED after boot for INTEL
 SSDSC2KG480G8, XCV10120 after 9b8b84879d4a ("block: Increase
 BLK_DEF_MAX_SECTORS_CAP")
Message-ID: <176839089913.2398366.61500945766820256@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Control: forwarded -1 https://lore.kernel.org/regressions/176839089913.2398366.61500945766820256@eldamar.lan 
Hi

A user reported a regression affecting his devices after 9b8b84879d4a
("block: Increase BLK_DEF_MAX_SECTORS_CAP") which maybe needs a
similar quirk like 2e9832713631 ("ata: libata-core: Quirk DELLBOSS VD
max_sectors").

The full report is at https://bugs.debian.org/1120831

One full boot log (without tainted kernel) is provided in
https://bugs.debian.org/1120831#55 , where:

Dec 10 18:56:03 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Dec 10 18:56:03 kernel: ata1.00: Model 'INTEL SSDSC2KG480G8', rev 'XCV10120', applying quirks: zeroaftertrim
Dec 10 18:56:03 kernel: ata1.00: ATA-10: INTEL SSDSC2KG480G8, XCV10120, max UDMA/133
Dec 10 18:56:03 kernel: ata1.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32)
Dec 10 18:56:03 kernel: ata1.00: configured for UDMA/133
Dec 10 18:56:03 kernel: scsi 0:0:0:0: Direct-Access ATA INTEL SSDSC2KG48 0120 PQ: 0 ANSI: 5
Dec 10 18:56:03 kernel: iTCO_vendor_support: vendor-support=0
Dec 10 18:56:03 kernel: ata1.00: Enabling discard_zeroes_data
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] 937703088 512-byte logical blocks: (480 GB/447 GiB)
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] Write Protect is off
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 10 18:56:03 kernel: sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
Dec 10 18:56:03 kernel: ata1.00: Enabling discard_zeroes_data
[...]
Dec 10 18:58:49 kernel: ata1.00: exception Emask 0x0 SAct 0x81fff8 SErr 0x0 action 0x6 frozen
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/00:18:50:4a:4c/20:00:0c:00:00/40 tag 3 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/00:20:50:6a:4c/20:00:0c:00:00/40 tag 4 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/00:28:50:8a:4c/20:00:0c:00:00/40 tag 5 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/80:30:88:28:00/00:00:00:00:00/40 tag 6 ncq dma 65536 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/28:38:00:08:40/00:00:00:00:00/40 tag 7 ncq dma 20480 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/48:40:38:08:40/00:00:00:00:00/40 tag 8 ncq dma 36864 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/28:48:00:08:80/00:00:00:00:00/40 tag 9 ncq dma 20480 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/48:50:38:08:80/00:00:00:00:00/40 tag 10 ncq dma 36864 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/80:58:00:08:c0/00:00:00:00:00/40 tag 11 ncq dma 65536 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/10:60:00:08:00/00:00:01:00:00/40 tag 12 ncq dma 8192 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/60:68:20:08:00/00:00:01:00:00/40 tag 13 ncq dma 49152 in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/80:70:00:08:40/00:00:01:00:00/40 tag 14 ncq dma 65536 in res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/80:78:00:08:80/00:00:01:00:00/40 tag 15 ncq dma 65536 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/80:80:00:08:c0/00:00:01:00:00/40 tag 16 ncq dma 65536 in res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 61/20:b8:68:28:b2/00:00:1e:00:00/40 tag 23 ncq dma 16384 out res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:58:49 kernel: ata1.00: status: { DRDY }
Dec 10 18:58:49 kernel: ata1: hard resetting link
Dec 10 18:58:49 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Dec 10 18:58:49 kernel: ata1.00: configured for UDMA/133
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#6 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#6 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#6 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#6 CDB: Read(10) 28 00 00 00 28 88 00 00 80 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 10376 op 0x0:(READ) flags 0x83700 phys_seg 16 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#7 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#7 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 00 40 08 00 00 00 28 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 4196352 op 0x0:(READ) flags 0x83700 phys_seg 5 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#8 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#8 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#8 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#8 CDB: Read(10) 28 00 00 40 08 38 00 00 48 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 4196408 op 0x0:(READ) flags 0x83700 phys_seg 9 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#9 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#9 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#9 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#9 CDB: Read(10) 28 00 00 80 08 00 00 00 28 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 8390656 op 0x0:(READ) flags 0x83700 phys_seg 5 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#10 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#10 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#10 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 00 80 08 38 00 00 48 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 8390712 op 0x0:(READ) flags 0x83700 phys_seg 9 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#11 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#11 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#11 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#11 CDB: Read(10) 28 00 00 c0 08 00 00 00 80 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 12584960 op 0x0:(READ) flags 0x83700 phys_seg 16 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#12 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#12 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 01 00 08 00 00 00 10 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 16779264 op 0x0:(READ) flags 0x83700 phys_seg 2 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#13 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#13 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 01 00 08 20 00 00 60 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 16779296 op 0x0:(READ) flags 0x83700 phys_seg 12 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#14 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#14 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 01 40 08 00 00 00 80 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 20973568 op 0x0:(READ) flags 0x83700 phys_seg 16 prio class 2
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#15 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=35s
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#15 Sense Key : Aborted Command [current]
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#15 Add. Sense: No additional sense information
Dec 10 18:58:49 kernel: sd 0:0:0:0: [sda] tag#15 CDB: Read(10) 28 00 01 80 08 00 00 00 80 00
Dec 10 18:58:49 kernel: I/O error, dev sda, sector 25167872 op 0x0:(READ) flags 0x83700 phys_seg 16 prio class 2
Dec 10 18:58:49 kernel: ata1: EH complete
Dec 10 18:58:49 kernel: ata1.00: Enabling discard_zeroes_data
Dec 10 18:59:21 kernel: ata1.00: exception Emask 0x0 SAct 0x600 SErr 0x0 action 0x6 frozen
Dec 10 18:59:21 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:59:21 kernel: ata1.00: cmd 60/00:48:50:6a:4c/20:00:0c:00:00/40 tag 9 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:59:21 kernel: ata1.00: status: { DRDY }
Dec 10 18:59:21 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:59:21 kernel: ata1.00: cmd 60/00:50:50:8a:4c/20:00:0c:00:00/40 tag 10 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:59:21 kernel: ata1.00: status: { DRDY }
Dec 10 18:59:21 kernel: ata1: hard resetting link
Dec 10 18:59:21 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Dec 10 18:59:21 kernel: ata1.00: configured for UDMA/133
Dec 10 18:59:21 kernel: ata1: EH complete
Dec 10 18:59:51 kernel: ata1.00: exception Emask 0x0 SAct 0x20 SErr 0x0 action 0x6 frozen
Dec 10 18:59:51 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:59:51 kernel: ata1.00: cmd 60/00:28:50:8a:4c/20:00:0c:00:00/40 tag 5 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 18:59:51 kernel: ata1.00: status: { DRDY }
Dec 10 18:59:51 kernel: ata1: hard resetting link
Dec 10 18:59:52 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Dec 10 18:59:52 kernel: ata1.00: configured for UDMA/133
Dec 10 18:59:52 kernel: ata1: EH complete
Dec 10 18:59:52 kernel: ata1.00: Enabling discard_zeroes_data
Dec 10 19:00:22 kernel: ata1.00: NCQ disabled due to excessive errors
Dec 10 19:00:22 kernel: ata1.00: exception Emask 0x0 SAct 0x20003400 SErr 0x0 action 0x6 frozen
Dec 10 19:00:22 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 19:00:22 kernel: ata1.00: cmd 60/00:50:50:2a:4c/20:00:0c:00:00/40 tag 10 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 19:00:22 kernel: ata1.00: status: { DRDY }
Dec 10 19:00:22 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 19:00:22 kernel: ata1.00: cmd 60/00:60:50:6a:4c/20:00:0c:00:00/40 tag 12 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 19:00:22 kernel: ata1.00: status: { DRDY }
Dec 10 19:00:22 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 19:00:22 kernel: ata1.00: cmd 60/00:68:50:8a:4c/20:00:0c:00:00/40 tag 13 ncq dma 4194304 in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 19:00:22 kernel: ata1.00: status: { DRDY }
Dec 10 19:00:22 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 19:00:22 kernel: ata1.00: cmd 60/08:e8:68:08:c0/00:00:01:00:00/40 tag 29 ncq dma 4096 in res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 10 19:00:22 kernel: ata1.00: status: { DRDY }
Dec 10 19:00:22 kernel: ata1: hard resetting link
Dec 10 19:00:22 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Dec 10 19:00:22 kernel: ata1.00: configured for UDMA/133
Dec 10 19:00:22 kernel: ata1: EH complete
Dec 10 19:00:22 kernel: ata1.00: Enabling discard_zeroes_data

The user bisected the issue down to the mentioned 9b8b84879d4a
("block: Increase BLK_DEF_MAX_SECTORS_CAP").

#regzbot introduced: 9b8b84879d4adc506b0d3944e20b28d9f3f6994b
#regzbot link: https://bugs.debian.org/1120831

What helps as a workaround was to apply a udev rule 

ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sda", ATTR{queue/max_sectors_kb}="1280"

and decreasing again max_sectors_kb to 1280 KiB.

So maybe this device would need a similar quirk and limit the maximum
size for these device I/O's to 2560 sectors?

Regards,
Salvatore

